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
    return _fetchTickets(page: 1, status: status);
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
      status: _currentStatus == 'ALL' ? null : _currentStatus,
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
