import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum Status { pending, won, lost }

class TicketCard extends StatelessWidget {
  final String ticketId;
  final String bookingCode;
  final double betAmount;
  final DateTime trackedAt;
  final String description;
  final double totalOdds;
  final String provider;
  final Status status;
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
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final scheme = theme.colorScheme;

    final (badgeBg, badgeFg, label, statusIcon) = switch (status) {
      Status.pending => (
        scheme.primary.withValues(alpha: 0.14),
        scheme.primary,
        'Pending',
        LucideIcons.activity,
      ),
      Status.won => (
        const Color(0xff163a2e),
        const Color(0xff4ade80),
        'Won',
        LucideIcons.checkCircle2,
      ),
      Status.lost => (
        scheme.secondary,
        scheme.mutedForeground,
        'Lost',
        LucideIcons.xCircle,
      ),
    };

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // To something like:
            color: scheme.card == scheme.background
                ? const Color(0xff1c1917) // Slightly lighter than background
                : scheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: scheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Provider & Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: scheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          LucideIcons.ticket,
                          size: 14,
                          color: scheme.foreground,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        provider.toUpperCase(),
                        style: theme.textTheme.small.copyWith(
                          color: scheme.mutedForeground,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Booking Code & Copy Action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description.isNotEmpty ? description : 'Booking Code',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.small.copyWith(
                            color: scheme.mutedForeground,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          bookingCode,
                          style: theme.textTheme.large.copyWith(
                            color: scheme.foreground,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: bookingCode));
                      ShadToaster.of(context).show(
                        const ShadToast(
                          description: Text('Booking code copied to clipboard'),
                        ),
                      );
                    },
                    icon: Icon(
                      LucideIcons.copy,
                      size: 18,
                      color: scheme.mutedForeground,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Divider(color: scheme.border, height: 1),
              const SizedBox(height: 16),

              // Bottom Stats Row: Odds, Stake, Tracked Time
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
                    '₦$betAmount',
                    scheme.foreground,
                  ),
                  _buildStat(
                    context,
                    'Tracked',
                    _relativeTime(trackedAt),
                    scheme.mutedForeground,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.small.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600,
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
