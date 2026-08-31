import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/providers/history_controller.dart';

part 'history_filter_provider.g.dart';

class TicketFilter {
  final double? minOdds;
  final double? maxOdds;
  final double? minStake;
  final double? maxStake;
  final DateTimeRange? dateRange;

  const TicketFilter({
    this.minOdds,
    this.maxOdds,
    this.minStake,
    this.maxStake,
    this.dateRange,
  });

  TicketFilter copyWith({
    double? minOdds,
    double? maxOdds,
    double? minStake,
    double? maxStake,
    DateTimeRange? dateRange,
    bool clearMinOdds = false,
    bool clearMaxOdds = false,
    bool clearMinStake = false,
    bool clearMaxStake = false,
    bool clearDateRange = false,
  }) {
    return TicketFilter(
      minOdds: clearMinOdds ? null : (minOdds ?? this.minOdds),
      maxOdds: clearMaxOdds ? null : (maxOdds ?? this.maxOdds),
      minStake: clearMinStake ? null : (minStake ?? this.minStake),
      maxStake: clearMaxStake ? null : (maxStake ?? this.maxStake),
      dateRange: clearDateRange ? null : (dateRange ?? this.dateRange),
    );
  }

  bool get isEmpty =>
      minOdds == null &&
      maxOdds == null &&
      minStake == null &&
      maxStake == null &&
      dateRange == null;
}

@Riverpod(keepAlive: true)
class HistoryFilterState extends _$HistoryFilterState {
  @override
  TicketFilter build() => const TicketFilter();

  void updateFilter(TicketFilter filter) {
    state = filter;
  }

  void clear() {
    state = const TicketFilter();
  }
}

@Riverpod(keepAlive: true)
AsyncValue<List<HistoryItem>> filteredHistory(Ref ref, String status) {
  final filter = ref.watch(historyFilterStateProvider);
  final ticketsAsync = ref.watch(historyControllerProvider(status));

  return ticketsAsync.whenData((tickets) {
    if (filter.isEmpty) return tickets;

    return tickets.where((ticket) {
      if (filter.minOdds != null && ticket.totalOdds < filter.minOdds!) {
        return false;
      }
      if (filter.maxOdds != null && ticket.totalOdds > filter.maxOdds!) {
        return false;
      }
      if (filter.minStake != null && (ticket.stake ?? 0) < filter.minStake!) {
        return false;
      }
      if (filter.maxStake != null && (ticket.stake ?? 0) > filter.maxStake!) {
        return false;
      }
      if (filter.dateRange != null) {
        if (ticket.trackedAt.isBefore(filter.dateRange!.start) ||
            ticket.trackedAt.isAfter(
              filter.dateRange!.end.add(const Duration(days: 1)),
            )) {
          return false;
        }
      }
      return true;
    }).toList();
  });
}
