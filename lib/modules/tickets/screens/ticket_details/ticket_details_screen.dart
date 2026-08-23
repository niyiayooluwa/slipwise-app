import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/models/ticket_detail.dart';
import 'package:slipwise/modules/tickets/screens/shared/ticket_detail_controller.dart';
import 'package:slipwise/modules/tickets/screens/ticket_details/widgets/edit_ticket_modal.dart';
import 'package:slipwise/core/utils/market_formatter.dart';

class TicketDetailsScreen extends HookConsumerWidget {
  final HistoryItem initialTicket;

  const TicketDetailsScreen({super.key, required this.initialTicket});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    // Maintain local state of the ticket for optimistic updates
    final ticketState = useState<HistoryItem>(initialTicket);
    final ticket = ticketState.value;

    final selectionsAsync = ref.watch(
      ticketDetailControllerProvider(ticket.ticketId),
    );

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: colorScheme.foreground),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Ticket Details',
          style: theme.textTheme.h4.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.foreground,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.pencil, color: colorScheme.foreground),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => EditTicketModal(
                  ticket: ticket,
                  onSaved: (updatedTicket) {
                    ticketState.value = updatedTicket;
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSummaryCard(ticket, theme, colorScheme),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Text(
                'Selections',
                style: theme.textTheme.large.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.foreground,
                ),
              ),
            ),
          ),

          selectionsAsync.when(
            data: (selections) {
              if (selections.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No selections found.',
                      style: TextStyle(color: colorScheme.mutedForeground),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final selection = selections[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildSelectionCard(selection, theme, colorScheme),
                    );
                  }, childCount: selections.length),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, stack) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    HistoryItem ticket,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    final statusColor = _getStatusColor(ticket.overallStatus);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  ticket.overallStatus.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  ticket.provider,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.foreground,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            ticket.code,
            style: theme.textTheme.h3.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          if (ticket.description != null && ticket.description!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(ticket.description!, style: theme.textTheme.muted),
          ],
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryStat(
                'Total Odds',
                ticket.totalOdds.toStringAsFixed(2),
                colorScheme,
              ),
              _buildSummaryStat(
                'Stake',
                ticket.stake != null && ticket.stake! > 0
                    ? '₦${ticket.stake!.toStringAsFixed(0)}'
                    : '-',
                colorScheme,
              ),
              _buildSummaryStat(
                'Potential Win',
                ticket.stake != null && ticket.stake! > 0
                    ? '₦${(ticket.stake! * ticket.totalOdds).toStringAsFixed(0)}'
                    : '-',
                colorScheme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(
    String label,
    String value,
    ShadColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: colorScheme.mutedForeground),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.foreground,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionCard(
    TicketDetailItem selection,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    final statusColor = _getStatusColor(selection.matchStatus);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${selection.homeTeam} vs ${selection.awayTeam}',
                  style: theme.textTheme.small.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4, left: 8),
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  MarketFormatter.formatMarket(
                    selection.marketType,
                    selection.marketSpec,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.foreground,
                  ),
                ),
              ),
              Text(
                selection.odds.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'won':
        return const Color(0xff4ade80);
      case 'lost':
        return const Color(0xfff87171);
      default:
        return const Color(0xfffbbf24);
    }
  }
}
