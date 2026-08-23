import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';

part 'history_controller.g.dart';

@riverpod
class HistoryController extends _$HistoryController {
  int _currentPage = 1;
  final List<HistoryItem> _allTickets = [];
  bool _hasNextPage = true;
  bool _isLoadingMore = false;

  @override
  Future<List<HistoryItem>> build(String status) async {
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
      status: status,
    );

    return result.fold(
      ifLeft: (failure) => throw Exception(failure.message),
      ifRight: (response) {
        _currentPage = response.meta.page;
        _hasNextPage = response.meta.hasNext;

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

  Future<List<HistoryItem>> loadMore() async {
    if (!_hasNextPage || _isLoadingMore)
      return List<HistoryItem>.from(_allTickets);

    _isLoadingMore = true;
    try {
      final result = await ref
          .read(ticketRepositoryProvider)
          .getTickets(page: _currentPage + 1, limit: 20, status: status);

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
