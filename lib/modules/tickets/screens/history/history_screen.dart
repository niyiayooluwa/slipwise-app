import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/home/screens/widgets/ticket_card.dart';
import 'package:slipwise/modules/tickets/screens/history/history_controller.dart';
import 'package:slipwise/modules/tickets/screens/history/history_search_provider.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedTab = useState<String>('PENDING');

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140.0,
            pinned: true,
            backgroundColor: colorScheme.background,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.55),
                      colorScheme.primary.withValues(alpha: 0.35),
                      colorScheme.primary.withValues(alpha: 0.25),
                      colorScheme.primary.withValues(alpha: 0.15),
                      colorScheme.primary.withValues(alpha: 0.08),
                      colorScheme.primary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.25, 0.45, 0.65, 0.85, 1.0],
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'History',
                style: theme.textTheme.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.foreground,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: ShadInput(
                placeholder: const Text(
                  'Search by booking code or description...',
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    LucideIcons.search,
                    size: 16,
                    color: colorScheme.mutedForeground,
                  ),
                ),
                onChanged: (val) {
                  ref.read(historySearchQueryProvider.notifier).state = val;
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverFillRemaining(
            child: ShadTabs<String>(
              value: selectedTab.value,
              onChanged: (val) => selectedTab.value = val,
              tabs: [
                ShadTab(
                  value: 'PENDING',
                  content: _TicketList(status: 'PENDING'),
                  child: const Text('Active'),
                ),
                ShadTab(
                  value: 'WON',
                  content: _TicketList(status: 'WON'),
                  child: const Text('Won'),
                ),
                ShadTab(
                  value: 'LOST',
                  content: _TicketList(status: 'LOST'),
                  child: const Text('Lost'),
                ),
              ],
            ),
          ),
        ],
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

    return ticketsAsync.when(
      data: (tickets) {
        if (tickets.isEmpty) {
          return const Center(child: Text('No tickets found.'));
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
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final ticket = tickets[index];
                return TicketCard(
                  ticketId: ticket.ticketId,
                  bookingCode: ticket.code,
                  betAmount: ticket.stake ?? 0.0,
                  trackedAt: ticket.trackedAt,
                  description: ticket.description ?? '',
                  totalOdds: ticket.totalOdds,
                  provider: ticket.provider,
                  status: _mapStatus(ticket.overallStatus),
                  onTap: () {
                    context.push('/ticket-details', extra: ticket);
                  },
                );
              },
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(child: Text('Error loading tickets: $e')),
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
