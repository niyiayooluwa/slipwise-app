import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/semantic_colors.dart';
import 'package:slipwise/core/utils/toast_utils.dart';

// A simple enum describing the status a ticket can be in
enum Status { pending, won, lost }

// Widget for drawing a ticket
class TicketCard extends StatelessWidget {
  final String ticketId;
  final String bookingCode;
  final double betAmount;
  final DateTime trackedAt;
  final String description;
  final double totalOdds;
  final String provider;
  final Status status;
  final int totalLegs;
  final int wonLegs;
  final int lostLegs;
  final int pendingLegs;
  final VoidCallback? onTap;

  const TicketCard({
    super.key,
    required this.ticketId,
    required this.bookingCode,
    required this.betAmount,
    required this.trackedAt,
    required this.description,
    required this.totalOdds,
    required this.provider,
    required this.status,
    this.totalLegs = 0,
    this.wonLegs = 0,
    this.lostLegs = 0,
    this.pendingLegs = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final scheme = theme.colorScheme;

    final (badgeBg, badgeFg, label, statusIcon) = switch (status) {
      Status.pending => (
        context.statusPending.withValues(alpha: 0.15),
        context.statusPending,
        'Pending',
        LucideIcons.activity,
      ),
      Status.won => (
        context.statusWon.withValues(alpha: 0.15),
        context.statusWon,
        'Won',
        LucideIcons.checkCircle2,
      ),
      Status.lost => (
        context.statusLost.withValues(alpha: 0.15),
        context.statusLost,
        'Lost',
        LucideIcons.xCircle,
      ),
    };

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: scheme.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: scheme.border),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Provider + Relative Time & Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (provider.toLowerCase() == 'sportybet')
                          SvgPicture.asset(
                            'assets/drawables/sportybet.svg',
                            height: 20,
                            alignment: Alignment.centerLeft,
                            colorFilter: ColorFilter.mode(
                              scheme.foreground,
                              BlendMode.srcIn,
                            ),
                          )
                        else ...[
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: scheme.secondary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              LucideIcons.ticket,
                              size: 13,
                              color: scheme.foreground,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              provider.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.small.copyWith(
                                color: scheme.mutedForeground,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: TextStyle(
                            color: scheme.mutedForeground.withValues(
                              alpha: 0.5,
                            ),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _relativeTime(trackedAt),
                          style: theme.textTheme.small.copyWith(
                            color: scheme.mutedForeground,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 12, color: badgeFg),
                        const SizedBox(width: 4),
                        Text(
                          label,
                          style: theme.textTheme.small.copyWith(
                            color: badgeFg,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Booking Code & Copy Action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (description.isNotEmpty) ...[
                          Text(
                            description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.small.copyWith(
                              color: scheme.mutedForeground,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 3),
                        ],
                        Text(
                          bookingCode,
                          style: theme.textTheme.h4.copyWith(
                            color: scheme.foreground,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: bookingCode));
                      context.showToast(
                        description: 'Booking code copied to clipboard',
                      );
                    },
                    icon: Icon(
                      LucideIcons.copy,
                      size: 18,
                      color: scheme.mutedForeground,
                    ),
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),

              // Real-time Leg Progress Indicator (if legs available)
              if (totalLegs > 0) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: SizedBox(
                          height: 5,
                          child: Row(
                            children: [
                              if (wonLegs > 0)
                                Expanded(
                                  flex: wonLegs,
                                  child: Container(color: context.statusWon),
                                ),
                              if (lostLegs > 0)
                                Expanded(
                                  flex: lostLegs,
                                  child: Container(color: context.statusLost),
                                ),
                              if (pendingLegs > 0)
                                Expanded(
                                  flex: pendingLegs,
                                  child: Container(
                                    color: scheme.border.withValues(alpha: 0.9),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _formatLegProgress(
                        wonLegs,
                        lostLegs,
                        pendingLegs,
                        totalLegs,
                      ),
                      style: theme.textTheme.small.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _legTextColor(
                          context,
                          wonLegs,
                          lostLegs,
                          pendingLegs,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 14),
              Divider(color: scheme.border, height: 1, thickness: 1),
              const SizedBox(height: 12),

              // Bottom Stats Row: Odds, Stake, Est. Payout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(
                    context,
                    'Odds',
                    '${totalOdds.toStringAsFixed(2)}x',
                    scheme.foreground,
                  ),
                  _buildStat(
                    context,
                    'Stake',
                    '₦${NumberFormat('#,##0.00').format(betAmount)}',
                    scheme.foreground,
                  ),
                  _buildStat(
                    context,
                    'Est. Payout',
                    '₦${NumberFormat('#,##0.00').format(totalOdds * betAmount)}',
                    context.statusWon,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatLegProgress(int won, int lost, int pending, int total) {
    if (lost > 0) {
      return won > 0 ? '$won Won • $lost Lost' : '$lost Lost';
    }
    if (won > 0) {
      return '$won/$total Won';
    }
    return '$pending Pending';
  }

  Color _legTextColor(BuildContext context, int won, int lost, int pending) {
    if (lost > 0) return context.statusLost;
    if (won > 0) return context.statusWon;
    return context.statusPending;
  }

  Widget _buildStat(
    BuildContext context,
    String label,
    String value,
    Color valueColor,
  ) {
    final theme = ShadTheme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.small.copyWith(
            color: scheme.mutedForeground,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: theme.textTheme.small.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
