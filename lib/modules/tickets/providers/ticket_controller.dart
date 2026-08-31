import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';

part 'ticket_controller.g.dart';

@riverpod
class TicketController extends _$TicketController {
  int _currentPage = 1;
  final List<HistoryItem> _allTickets = [];
  bool _hasNextPage = true;
  bool _isLoadingMore = false;
  DateTime? _lastSyncTime;

  @override
  Future<List<HistoryItem>> build() async {
    // 1. Load instantly from Offline Cache
    final cacheBox = Hive.box<HistoryItem>('tickets_cache_ALL');
    final syncBox = Hive.box<String>('sync_cache');

    final cachedTickets = cacheBox.values.toList();
    if (cachedTickets.isNotEmpty) {
      _allTickets.clear();
      _allTickets.addAll(cachedTickets);

      final savedTime = syncBox.get('ticket_last_sync');
      if (savedTime != null) {
        _lastSyncTime = DateTime.tryParse(savedTime);
      }

      final savedHasNext = syncBox.get('ticket_has_next');
      if (savedHasNext != null) {
        _hasNextPage = savedHasNext == 'true';
      } else {
        _hasNextPage = false;
      }

      // 2. Fire the Delta-Sync in the background without blocking the UI
      Future.microtask(() => fetchUpdates());

      return List<HistoryItem>.from(_allTickets);
    }

    // Initial Load
    return _fetchTickets(page: 1);
  }

  void _saveToCache() {
    final cacheBox = Hive.box<HistoryItem>('tickets_cache_ALL');
    final syncBox = Hive.box<String>('sync_cache');

    // Overwrite box safely
    cacheBox.clear().then((_) {
      cacheBox.addAll(_allTickets);
    });

    if (_lastSyncTime != null) {
      syncBox.put('ticket_last_sync', _lastSyncTime!.toIso8601String());
    }
    syncBox.put('ticket_has_next', _hasNextPage ? 'true' : 'false');
  }

  Future<List<HistoryItem>> _fetchTickets({
    required int page,
    String? status,
  }) async {
    final repository = ref.read(ticketRepositoryProvider);

    final result = await repository.getTickets(
      page: page,
      limit: 20,
      status: status,
    );

    return result.fold(
      ifLeft: (failure) {
        // Throw the actual failure message
        throw Exception(failure.message);
      },
      ifRight: (response) {
        _currentPage = response.meta.page;
        _hasNextPage = response.meta.hasNext;
        _lastSyncTime = DateTime.now().toUtc();

        if (page == 1) {
          _allTickets
            ..clear()
            ..addAll(response.data);

          // Save to cache for offline first load
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
      since: sinceIso,
    );

    return result.fold(
      ifLeft: (_) => false, // Silently ignore polling errors and treat as empty
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
        _lastSyncTime = DateTime.now().toUtc();

        // Save merged list to cache
        _saveToCache();

        return hasData;
      },
    );
  }

  Future<List<HistoryItem>> loadMore() async {
    if (!_hasNextPage || _isLoadingMore) {
      // Return current tickets if no more pages or already loading
      return List<HistoryItem>.from(_allTickets);
    }

    // Set isLoadingMore to true
    _isLoadingMore = true;

    try {
      final result = await ref
          .read(ticketRepositoryProvider)
          .getTickets(page: _currentPage + 1, limit: 20);

      // IMPORTANT: Return the result of fold
      return result.fold(
        ifLeft: (failure) {
          // Throw to let the catch block handle it
          throw Exception(failure.message);
        },
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

  Future<void> deleteTicket(String id) async {
    final repository = ref.read(ticketRepositoryProvider);

    // Optimistic update - make a proper copy
    final currentTickets = List<HistoryItem>.from(_allTickets);

    // Remove from local list
    _allTickets.removeWhere((ticket) => ticket.ticketId == id);
    state = AsyncValue.data(List<HistoryItem>.from(_allTickets));

    final result = await repository.deleteTicket(id);

    result.fold(
      ifLeft: (failure) {
        // Revert on error
        _allTickets
          ..clear()
          ..addAll(currentTickets);
        state = AsyncValue.data(List<HistoryItem>.from(_allTickets));
        throw Exception(failure.message);
      },
      ifRight: (response) {
        state = AsyncValue.data(List<HistoryItem>.from(_allTickets));
      },
    );
  }

  //Helper Getters for UI
  List<HistoryItem> get pendingTickets {
    return _allTickets.where((t) => t.overallStatus == 'pending').toList();
  }

  List<HistoryItem> get wonTickets {
    return _allTickets.where((t) => t.overallStatus == 'won').toList();
  }

  List<HistoryItem> get lostTickets {
    return _allTickets.where((t) => t.overallStatus == 'lost').toList();
  }

  bool get hasMorePages => _hasNextPage;
  bool get isLoadingMore => _isLoadingMore;
}
