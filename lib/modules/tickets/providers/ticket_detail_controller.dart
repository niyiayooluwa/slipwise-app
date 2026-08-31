import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/models/ticket_detail.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';

part 'ticket_detail_controller.g.dart';

@riverpod
class TicketDetailController extends _$TicketDetailController {
  @override
  Future<List<TicketDetailItem>> build(String ticketId) async {
    final repository = ref.read(ticketRepositoryProvider);
    final result = await repository.getTicketDetails(ticketId);

    return result.fold(
      ifLeft: (failure) => throw Exception(failure.message),
      ifRight: (details) => _sortDetails(details),
    );
  }

  Future<bool> fetchUpdates() async {
    final repository = ref.read(ticketRepositoryProvider);
    final result = await repository.getTicketDetails(ticketId);

    return result.fold(
      ifLeft: (_) => false, // Silently ignore polling errors
      ifRight: (details) {
        state = AsyncValue.data(_sortDetails(details));
        return true;
      },
    );
  }

  List<TicketDetailItem> _sortDetails(List<TicketDetailItem> items) {
    // We modify a copy of the list
    final list = List<TicketDetailItem>.from(items);
    list.sort((a, b) {
      final rankA = _getSortRank(a);
      final rankB = _getSortRank(b);
      
      if (rankA != rankB) {
        return rankA.compareTo(rankB);
      }
      
      // If same rank (e.g. both pending), sort by startTime (earliest first)
      return a.startTime.compareTo(b.startTime);
    });
    return list;
  }

  int _getSortRank(TicketDetailItem item) {
    if (item.matchStatus == 'LIVE') return 0;
    if (item.selectionStatus == 'won') return 1;
    if (item.selectionStatus == 'pending') return 2;
    return 3; // lost/cut
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<HistoryItem> singleTicket(Ref ref, String ticketId) async {
  final repo = ref.read(ticketRepositoryProvider);
  final result = await repo.getTickets(limit: 50);
  return result.fold(
    ifLeft: (err) => throw Exception(err.message),
    ifRight: (resp) {
      final ticket = resp.data.where((t) => t.ticketId == ticketId).firstOrNull;
      if (ticket == null) {
        throw Exception('Ticket not found');
      }
      return ticket;
    },
  );
}
