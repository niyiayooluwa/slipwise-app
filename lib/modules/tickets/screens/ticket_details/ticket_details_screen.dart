import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/models/ticket_detail.dart';
import 'package:slipwise/modules/tickets/providers/ticket_detail_controller.dart';
import 'package:slipwise/modules/tickets/screens/ticket_details/widgets/edit_ticket_modal.dart';
import 'package:slipwise/core/ui/error_state_widget.dart';

class TicketDetailsScreen extends HookConsumerWidget {
  final HistoryItem initialTicket;
  final String? heroTag;

  const TicketDetailsScreen({
    super.key,
    required this.initialTicket,
    this.heroTag,
  });

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
      body: SafeArea(
        bottom: true,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Hero(
                  tag: heroTag ?? 'ticket-${ticket.ticketId}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: _buildSummaryCard(
                      context,
                      ticket,
                      theme,
                      colorScheme,
                    ),
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
                        child: _buildSelectionCard(
                          context,
                          selection,
                          theme,
                          colorScheme,
                        ),
                      );
                    }, childCount: selections.length),
                  ),
                );
              },
              loading: () => SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return _buildSkeletonSelectionCard(
                      context,
                      theme,
                      colorScheme,
                    );
                  }, childCount: 3),
                ),
              ),
              error: (e, stack) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorStateWidget(
                  error: e,
                  onRetry: () => ref.refresh(
                    ticketDetailControllerProvider(ticket.ticketId),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    HistoryItem ticket,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    final statusColor = _getStatusColor(ticket.overallStatus);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff0E0C0B),
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
                    ? '₦${NumberFormat('#,##0.00').format(ticket.stake!)}'
                    : '-',
                colorScheme,
              ),
              _buildSummaryStat(
                'Potential Win',
                ticket.stake != null && ticket.stake! > 0
                    ? '₦${NumberFormat('#,##0.00').format(ticket.stake! * ticket.totalOdds)}'
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

  Widget _buildSkeletonSelectionCard(
    BuildContext context,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xff0E0C0B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 2, color: colorScheme.muted),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colorScheme.muted,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 20,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: colorScheme.muted,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 100,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colorScheme.muted,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 24,
                          decoration: BoxDecoration(
                            color: colorScheme.muted,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 28,
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 20,
                          decoration: BoxDecoration(
                            color: colorScheme.muted,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard(
    BuildContext context,
    TicketDetailItem selection,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    final statusColor = _getStatusColor(selection.selectionStatus);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xff0E0C0B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              color: statusColor.withValues(alpha: 0.222222223),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (selection.matchStatus == 'LIVE')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  selection.liveTime ?? 'LIVE',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (selection.matchStatus == 'ENDED')
                          Text(
                            'FT',
                            style: theme.textTheme.small.copyWith(
                              color: colorScheme.mutedForeground,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else
                          Text(
                            DateFormat(
                              'dd MMM yyyy, HH:mm',
                            ).format(selection.startTime),
                            style: theme.textTheme.small.copyWith(
                              color: colorScheme.mutedForeground,
                              fontSize: 11,
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: statusColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            selection.selectionStatus.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Teams and Score
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${selection.homeTeam}   ',
                            style: theme.textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.foreground,
                            ),
                          ),
                          TextSpan(
                            text: selection.matchStatus == 'NOT_STARTED'
                                ? 'vs'
                                : '${selection.homeScore} - ${selection.awayScore}',
                            style: TextStyle(
                              fontSize: selection.matchStatus == 'NOT_STARTED'
                                  ? 12
                                  : 18,
                              fontStyle: selection.matchStatus == 'NOT_STARTED'
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: selection.matchStatus == 'NOT_STARTED'
                                  ? colorScheme.mutedForeground
                                  : colorScheme.foreground,
                            ),
                          ),
                          TextSpan(
                            text: '   ${selection.awayTeam}',
                            style: theme.textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.foreground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
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
                            selection.displaySelection ?? selection.selection,
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
