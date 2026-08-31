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
    // Initial Load
    return _fetchTickets(page: 1);
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
        } else {
          _allTickets.addAll(response.data);
        }

        return List<HistoryItem>.from(_allTickets);
      },
    );
  }

  Future<void> fetchUpdates() async {
    if (_lastSyncTime == null) return;

    final sinceIso = _lastSyncTime!.toUtc().toIso8601String();
    final repository = ref.read(ticketRepositoryProvider);

    final result = await repository.getTickets(
      page: 1,
      limit: 50,
      since: sinceIso,
    );

    result.fold(
      ifLeft: (_) {}, // Silently ignore polling errors
      ifRight: (response) {
        if (response.data.isNotEmpty) {
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
