import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/ui/ticket_card.dart';
import 'package:slipwise/modules/tickets/providers/history_controller.dart';
import 'package:slipwise/modules/tickets/providers/history_filter_provider.dart';
import 'package:slipwise/modules/tickets/screens/history/widgets/history_filter_bottom_sheet.dart';
import 'package:slipwise/core/ui/gradient_sliver_app_bar.dart';
import 'package:slipwise/core/ui/empty_state_widget.dart';
import 'package:slipwise/core/ui/error_state_widget.dart';
import 'package:slipwise/core/hooks/use_smart_polling.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedTab = useState<String>('ALL');

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          const GradientSliverAppBar(title: 'History'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          _buildFilterChip(
                            'ALL',
                            'All',
                            selectedTab.value,
                            (val) => selectedTab.value = val,
                            theme,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            'PENDING',
                            'Active',
                            selectedTab.value,
                            (val) => selectedTab.value = val,
                            theme,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            'WON',
                            'Won',
                            selectedTab.value,
                            (val) => selectedTab.value = val,
                            theme,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            'LOST',
                            'Lost',
                            selectedTab.value,
                            (val) => selectedTab.value = val,
                            theme,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.border),
                    ),
                    child: IconButton(
                      icon: Icon(
                        LucideIcons.slidersHorizontal,
                        size: 18,
                        color: colorScheme.foreground,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              const HistoryFilterBottomSheet(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverFillRemaining(
            child: IndexedStack(
              index: selectedTab.value == 'ALL'
                  ? 0
                  : selectedTab.value == 'PENDING'
                  ? 1
                  : selectedTab.value == 'WON'
                  ? 2
                  : 3,
              children: const [
                _TicketList(status: 'ALL'),
                _TicketList(status: 'PENDING'),
                _TicketList(status: 'WON'),
                _TicketList(status: 'LOST'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String value,
    String label,
    String selectedValue,
    Function(String) onSelected,
    ShadThemeData theme,
  ) {
    final isSelected = value == selectedValue;
    return GestureDetector(
      onTap: () => onSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.border,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.small.copyWith(
            color: isSelected
                ? theme.colorScheme.primaryForeground
                : theme.colorScheme.mutedForeground,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _TicketList extends HookConsumerWidget {
  final String status;

  const _TicketList({required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsync = ref.watch(filteredHistoryProvider(status));
    final controller = ref.watch(historyControllerProvider(status).notifier);

    // Conditional Polling: Only poll if there are pending/live tickets
    final shouldPoll =
        ticketsAsync.value?.any((t) => t.overallStatus == 'pending') ?? false;

    useSmartPolling(
      fetchUpdates: () => controller.fetchUpdates(),
      shouldPoll: shouldPoll,
    );

    return ticketsAsync.when(
      data: (tickets) {
        if (tickets.isEmpty) {
          return const EmptyStateWidget(
            title: 'No tickets found',
            message: 'Try adjusting your search or filter',
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refresh(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
                controller.loadMore();
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: tickets.length + (controller.hasMorePages ? 1 : 0),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index == tickets.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SpinKitThreeBounce(size: 16, color: Colors.white),
                    ),
                  );
                }
                final ticket = tickets[index];
                return Hero(
                  tag: 'ticket-${ticket.ticketId}-$status',
                  child: Material(
                    type: MaterialType.transparency,
                    child: TicketCard(
                      ticketId: ticket.ticketId,
                      bookingCode: ticket.code,
                      betAmount: ticket.stake ?? 0.0,
                      trackedAt: ticket.trackedAt,
                      description: ticket.description ?? '',
                      totalOdds: ticket.totalOdds,
                      provider: ticket.provider,
                      status: _mapStatus(ticket.overallStatus),
                      onTap: () {
                        context.push(
                          '/ticket-details',
                          extra: {
                            'ticket': ticket,
                            'heroTag': 'ticket-${ticket.ticketId}-$status',
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      loading: () => const Center(
        child: SpinKitThreeBounce(size: 16, color: Colors.white),
      ),
      error: (e, stack) =>
          ErrorStateWidget(error: e, onRetry: () => controller.refresh()),
    );
  }
}

Status _mapStatus(String statusStr) {
  switch (statusStr.toLowerCase()) {
    case 'won':
      return Status.won;
    case 'lost':
      return Status.lost;
    default:
      return Status.pending;
  }
}
