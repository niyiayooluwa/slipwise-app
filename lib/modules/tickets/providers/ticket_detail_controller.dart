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
      ifRight: (details) => details,
    );
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
