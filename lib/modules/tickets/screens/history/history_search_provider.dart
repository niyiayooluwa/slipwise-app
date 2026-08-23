import 'package:hooks_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/screens/history/history_controller.dart';

part 'history_search_provider.g.dart';

final historySearchQueryProvider = StateProvider<String>((ref) => '');

@riverpod
AsyncValue<List<HistoryItem>> filteredHistory(Ref ref, String status) {
  final query = ref.watch(historySearchQueryProvider).toLowerCase();
  final ticketsAsync = ref.watch(historyControllerProvider(status));

  return ticketsAsync.whenData((tickets) {
    if (query.isEmpty) return tickets;
    return tickets.where((ticket) {
      final code = ticket.code.toLowerCase();
      final desc = ticket.description?.toLowerCase() ?? '';
      return code.contains(query) || desc.contains(query);
    }).toList();
  });
}
