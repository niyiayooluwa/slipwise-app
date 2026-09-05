import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/models/ticket_detail.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';

part 'ticket_detail_controller.g.dart';

@riverpod
class TicketDetailController extends _$TicketDetailController {
  @override
  Future<TicketDetailsResponse> build(String ticketId) async {
    final repository = ref.read(ticketRepositoryProvider);
    final result = await repository.getTicketDetails(ticketId);

    return result.fold(
      ifLeft: (failure) => throw Exception(failure.message),
      ifRight: (response) =>
          response.copyWith(selections: _sortDetails(response.selections)),
    );
  }

  Future<bool> fetchUpdates() async {
    final repository = ref.read(ticketRepositoryProvider);
    final result = await repository.getTicketDetails(ticketId);

    return result.fold(
      ifLeft: (_) => false, // Silently ignore polling errors
      ifRight: (response) {
        state = AsyncValue.data(
          response.copyWith(selections: _sortDetails(response.selections)),
        );
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
  // 1. Check local Hive caches first for instant (0ms) resolution
  final cacheBoxes = [
    'tickets_cache_ALL',
    'tickets_cache_PENDING',
    'tickets_cache_WON',
    'tickets_cache_LOST',
  ];

  for (final boxName in cacheBoxes) {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box<HistoryItem>(boxName);
      final cachedTicket = box.values
          .where((t) => t.ticketId == ticketId || t.code == ticketId)
          .firstOrNull;
      if (cachedTicket != null) {
        return cachedTicket;
      }
    }
  }

  final repo = ref.read(ticketRepositoryProvider);

  // 2. Fetch from remote tickets list
  final historyResult = await repo.getTickets();
  final foundTicket = historyResult.fold(
    ifLeft: (_) => null,
    ifRight: (resp) => resp.data
        .where((t) => t.ticketId == ticketId || t.code == ticketId)
        .firstOrNull,
  );

  if (foundTicket != null) {
    return foundTicket;
  }

  // 3. Fallback: If not found in list, fetch specific ticket details directly
  final detailsResult = await repo.getTicketDetails(ticketId);
  return detailsResult.fold(
    ifLeft: (failure) => throw Exception(failure.message),
    ifRight: (detailsResponse) {
      final selections = detailsResponse.selections;
      if (selections.isEmpty) {
        throw Exception('Ticket not found or has no selections');
      }

      final summary = detailsResponse.summary;
      final overallStatus = summary.lostLegs > 0
          ? 'LOST'
          : (summary.wonLegs == summary.totalLegs && summary.totalLegs > 0
                ? 'WON'
                : 'PENDING');

      final totalOdds = selections.fold<double>(
        1.0,
        (acc, item) => acc * (item.odds > 0 ? item.odds : 1.0),
      );

      final sortedDates = selections.map((s) => s.startTime).toList()..sort();
      final trackedAt = sortedDates.isNotEmpty
          ? sortedDates.first
          : DateTime.now().toUtc();

      return HistoryItem(
        ticketId: ticketId,
        code: ticketId.length > 8
            ? ticketId.substring(0, 8).toUpperCase()
            : ticketId.toUpperCase(),
        provider: 'SPORTYBET',
        overallStatus: overallStatus,
        totalOdds: double.parse(totalOdds.toStringAsFixed(2)),
        stake: null,
        description: null,
        trackedAt: trackedAt,
        totalLegs: summary.totalLegs,
        wonLegs: summary.wonLegs,
        lostLegs: summary.lostLegs,
        pendingLegs: summary.pendingLegs,
      );
    },
  );
}
