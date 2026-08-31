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

    final cachedTickets = cacheBox.values.toList();
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

      // 2. Fire the Delta-Sync in the background without blocking the UI
      Future.microtask(() => fetchUpdates());

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
    final result = await repository.getTickets(
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
    if (_lastSyncTime == null) return false;

    // Rule 3: Conditional Polling (Only poll if there are active tickets)
    final hasActiveTickets = _allTickets.any(
      (t) => t.overallStatus == 'pending',
    );
    if (!hasActiveTickets) {
      return false; // Don't even hit the network
    }

    final sinceIso = _lastSyncTime!.toUtc().toIso8601String();
    final repository = ref.read(ticketRepositoryProvider);

    final result = await repository.getTickets(
      page: 1,
      limit: 50,
      status: _currentStatus == 'ALL' ? null : _currentStatus,
      since: sinceIso,
    );

    return result.fold(
      ifLeft: (_) => false, // Silently ignore polling errors
      ifRight: (response) {
        bool hasData = response.data.isNotEmpty;
        if (hasData) {
          bool updated = false;
          for (final updatedTicket in response.data) {
            final index = _allTickets.indexWhere(
              (t) => t.ticketId == updatedTicket.ticketId,
            );
            if (index != -1) {
              _allTickets[index] = updatedTicket;
              updated = true;
            } else {
              _allTickets.insert(0, updatedTicket);
              updated = true;
            }
          }
          if (updated) {
            state = AsyncValue.data(List<HistoryItem>.from(_allTickets));
          }
        }

        // Update sync time
        _lastSyncTime = DateTime.now().toUtc();

        // Save merged updates and new sync time to cache
        _saveToCache();

        return hasData;
      },
    );
  }

  Future<List<HistoryItem>> loadMore() async {
    if (!_hasNextPage || _isLoadingMore) {
      return List<HistoryItem>.from(_allTickets);
    }

    _isLoadingMore = true;
    try {
      final result = await ref
          .read(ticketRepositoryProvider)
          .getTickets(
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

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  bool get hasMorePages => _hasNextPage;
  bool get isLoadingMore => _isLoadingMore;
}
