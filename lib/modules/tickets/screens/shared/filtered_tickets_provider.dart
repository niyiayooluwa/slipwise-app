// filtered_tickets_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/screens/shared/ticket_controller.dart';
part 'filtered_tickets_provider.g.dart';

@riverpod
List<HistoryItem> pendingTickets(Ref ref) {
  final ticketsAsync = ref.watch(ticketControllerProvider);
  return ticketsAsync.value
          ?.where((t) => t.overallStatus == 'pending')
          .toList() ??
      [];
}

@riverpod
List<HistoryItem> wonTickets(Ref ref) {
  final ticketsAsync = ref.watch(ticketControllerProvider);
  return ticketsAsync.value?.where((t) => t.overallStatus == 'won').toList() ??
      [];
}

@riverpod
int pendingTicketsCount(Ref ref) {
  final pending = ref.watch(pendingTicketsProvider);
  return pending.length;
}
