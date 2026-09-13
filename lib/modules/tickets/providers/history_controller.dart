import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';

part 'history_controller.g.dart';

@Riverpod(keepAlive: true)
class HistoryController extends _$HistoryController {
  int _currentPage = 1;
  final List<HistoryItem> _allTickets = [];
  bool _hasNextPage = true;
  bool _isLoadingMore = false;
  DateTime? _lastSyncTime;
  late String _currentStatus;

  @override
  Future<List<HistoryItem>> build(String status) async {
    _currentStatus = status;

    // 1. Load instantly from Offline Cache
    final cacheBox = Hive.box<HistoryItem>('tickets_cache_$status');
    final syncBox = Hive.box<String>('sync_cache');

    final rawCachedTickets = cacheBox.values.toList();

    // Self-healing cache: For filtered boxes (PENDING/WON/LOST), silently drop any
    // ticket whose overallStatus no longer matches. This handles status transitions
    // that happened while the app was closed, without requiring a reinstall or
    // manual refresh. The ALL box accepts every status so no filtering needed.
    final cachedTickets = status == 'ALL'
        ? rawCachedTickets
        : rawCachedTickets
              .where((t) => t.overallStatus.toUpperCase() == status)
              .toList();

    if (cachedTickets.isNotEmpty) {
      _allTickets.clear();
      _allTickets.addAll(cachedTickets);

      final savedTime = syncBox.get('history_last_sync_$status');
      if (savedTime != null) {
        _lastSyncTime = DateTime.tryParse(savedTime);
      }

      final savedHasNext = syncBox.get('history_has_next_$status');
      if (savedHasNext != null) {
        _hasNextPage = savedHasNext == 'true';
      } else {
        _hasNextPage = false;
      }

      // 2. Fetch fresh page 1 in background and update state directly
      Future.microtask(() async {
        try {
          final freshTickets = await _fetchTickets(page: 1, status: status);
          state = AsyncValue.data(freshTickets);
        } catch (_) {
          // Keep cached data visible on offline/network errors
        }
      });

      return List<HistoryItem>.from(_allTickets);
    }

    // 3. Initial Load if no cache exists
    return _fetchTickets(page: 1, status: status);
  }

  void _saveToCache() {
    final cacheBox = Hive.box<HistoryItem>('tickets_cache_$_currentStatus');
    final syncBox = Hive.box<String>('sync_cache');

    // Overwrite box safely
    cacheBox.clear().then((_) {
      cacheBox.addAll(_allTickets);
    });

    if (_lastSyncTime != null) {
      syncBox.put(
        'history_last_sync_$_currentStatus',
        _lastSyncTime!.toIso8601String(),
      );
    }
    syncBox.put(
      'history_has_next_$_currentStatus',
      _hasNextPage ? 'true' : 'false',
    );
  }

  Future<List<HistoryItem>> _fetchTickets({
    required int page,
    required String status,
  }) async {
    final repository = ref.read(ticketRepositoryProvider);
    final result = status == 'ARCHIVED'
        ? await repository.getArchivedTickets(page: page, limit: 20)
        : await repository.getTickets(
            page: page,
            limit: 20,
            status: status == 'ALL' ? null : status,
          );

    return result.fold(
      ifLeft: (failure) => throw Exception(failure.message),
      ifRight: (response) {
        _currentPage = response.meta.page;
        _hasNextPage = response.meta.hasNext;
        _lastSyncTime = DateTime.now().toUtc();

        if (page == 1) {
          _allTickets
            ..clear()
            ..addAll(response.data);

          // Only sync cache for page 1 to ensure offline shows freshest first 20 items
          _saveToCache();
        } else {
          _allTickets.addAll(response.data);
        }

        return List<HistoryItem>.from(_allTickets);
      },
    );
  }

  Future<bool> fetchUpdates() async {
    try {
      final freshTickets = await _fetchTickets(page: 1, status: _currentStatus);
      state = AsyncValue.data(freshTickets);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<HistoryItem>> loadMore() async {
    if (!_hasNextPage || _isLoadingMore) {
      return List<HistoryItem>.from(_allTickets);
    }

    _isLoadingMore = true;
    try {
      final repository = ref.read(ticketRepositoryProvider);
      final result = _currentStatus == 'ARCHIVED'
          ? await repository.getArchivedTickets(
              page: _currentPage + 1,
              limit: 20,
            )
          : await repository.getTickets(
              page: _currentPage + 1,
              limit: 20,
              status: _currentStatus == 'ALL' ? null : _currentStatus,
            );

      return result.fold(
        ifLeft: (failure) => throw Exception(failure.message),
        ifRight: (response) {
          _currentPage = response.meta.page;
          _hasNextPage = response.meta.hasNext;
          _allTickets.addAll(response.data);

          final updatedList = List<HistoryItem>.from(_allTickets);
          state = AsyncValue.data(updatedList);
          return updatedList;
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception(e.toString());
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<bool> archiveTickets(List<String> ticketIds) async {
    final idSet = ticketIds.toSet();
    final archivedItems = _allTickets
        .where((t) => idSet.contains(t.ticketId))
        .toList();
    _allTickets.removeWhere((t) => idSet.contains(t.ticketId));
    state = AsyncValue.data(List<HistoryItem>.from(_allTickets));

    // Update active cache boxes
    final activeBoxes = [
      'tickets_cache_ALL',
      'tickets_cache_PENDING',
      'tickets_cache_WON',
      'tickets_cache_LOST',
    ];
    for (final boxName in activeBoxes) {
      if (Hive.isBoxOpen(boxName)) {
        final box = Hive.box<HistoryItem>(boxName);
        final keysToRemove = box.keys.where((k) {
          final item = box.get(k);
          return item != null && idSet.contains(item.ticketId);
        }).toList();
        for (final k in keysToRemove) {
          await box.delete(k);
        }
      }
    }

    // Add to archived cache box
    if (Hive.isBoxOpen('tickets_cache_ARCHIVED')) {
      final archiveBox = Hive.box<HistoryItem>('tickets_cache_ARCHIVED');
      for (final item in archivedItems) {
        await archiveBox.put(item.ticketId, item.copyWith(isArchived: true));
      }
    }

    ref.invalidate(historyControllerProvider);

    try {
      final repo = ref.read(ticketRepositoryProvider);
      final res = await repo.bulkArchiveTickets(ticketIds);
      return res.isRight;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unarchiveTickets(List<String> ticketIds) async {
    final idSet = ticketIds.toSet();
    final restoredItems = _allTickets
        .where((t) => idSet.contains(t.ticketId))
        .toList();
    _allTickets.removeWhere((t) => idSet.contains(t.ticketId));
    state = AsyncValue.data(List<HistoryItem>.from(_allTickets));

    // Remove from archived cache box
    if (Hive.isBoxOpen('tickets_cache_ARCHIVED')) {
      final archiveBox = Hive.box<HistoryItem>('tickets_cache_ARCHIVED');
      for (final id in ticketIds) {
        await archiveBox.delete(id);
      }
    }

    // Add back to active cache boxes
    if (Hive.isBoxOpen('tickets_cache_ALL')) {
      final allBox = Hive.box<HistoryItem>('tickets_cache_ALL');
      for (final item in restoredItems) {
        await allBox.put(item.ticketId, item.copyWith(isArchived: false));
      }
    }

    ref.invalidate(historyControllerProvider);

    try {
      final repo = ref.read(ticketRepositoryProvider);
      final res = await repo.bulkUnarchiveTickets(ticketIds);
      return res.isRight;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteTickets(List<String> ticketIds) async {
    final idSet = ticketIds.toSet();
    _allTickets.removeWhere((t) => idSet.contains(t.ticketId));
    state = AsyncValue.data(List<HistoryItem>.from(_allTickets));

    final allBoxes = [
      'tickets_cache_ALL',
      'tickets_cache_PENDING',
      'tickets_cache_WON',
      'tickets_cache_LOST',
      'tickets_cache_ARCHIVED',
    ];
    for (final boxName in allBoxes) {
      if (Hive.isBoxOpen(boxName)) {
        final box = Hive.box<HistoryItem>(boxName);
        final keysToRemove = box.keys.where((k) {
          final item = box.get(k);
          return item != null && idSet.contains(item.ticketId);
        }).toList();
        for (final k in keysToRemove) {
          await box.delete(k);
        }
      }
    }

    ref.invalidate(historyControllerProvider);

    try {
      final repo = ref.read(ticketRepositoryProvider);
      final res = await repo.bulkDeleteTickets(ticketIds);
      return res.isRight;
    } catch (_) {
      return false;
    }
  }

  Future<void> refresh() async {
    try {
      final freshTickets = await _fetchTickets(page: 1, status: _currentStatus);
      state = AsyncValue.data(freshTickets);
    } catch (e, stack) {
      if (_allTickets.isEmpty) {
        state = AsyncValue.error(e, stack);
      }
    }
  }

  bool get hasMorePages => _hasNextPage;
  bool get isLoadingMore => _isLoadingMore;
}
