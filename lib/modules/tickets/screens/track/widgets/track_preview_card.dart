import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:slipwise/modules/tickets/data/models/preview.dart';

class TrackPreviewCard extends HookWidget {
  final ShadThemeData theme;
  final ShadColorScheme colorScheme;
  final PreviewResponse preview;
  final TextEditingController stakeController;
  final TextEditingController descriptionController;

  const TrackPreviewCard({
    super.key,
    required this.theme,
    required this.colorScheme,
    required this.preview,
    required this.stakeController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final displayedSelections = isExpanded.value
        ? preview.selections
        : preview.selections.take(3).toList();

    String formatMarketType(String market) {
      return market
          .split('_')
          .map(
            (word) => word.isNotEmpty
                ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                : '',
          )
          .join(' ');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview Header (Styled like TicketCard)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          LucideIcons.ticket,
                          size: 14,
                          color: colorScheme.foreground,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        preview.provider.toUpperCase(),
                        style: theme.textTheme.small.copyWith(
                          color: colorScheme.mutedForeground,
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
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '${preview.totalOdds.toStringAsFixed(2)}x Odds',
                      style: theme.textTheme.small.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Booking Code',
                style: theme.textTheme.small.copyWith(
                  color: colorScheme.mutedForeground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                preview.code,
                style: theme.textTheme.large.copyWith(
                  color: colorScheme.foreground,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Selections summary
        Text(
          'Selections (${preview.selections.length})',
          style: theme.textTheme.large.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...displayedSelections.map((selection) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${selection.homeTeam} vs ${selection.awayTeam}',
                        style: theme.textTheme.small.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        selection.displaySelection ??
                            '${formatMarketType(selection.marketType)}: ${selection.selection}',
                        style: theme.textTheme.small.copyWith(
                          color: colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  selection.odds.toStringAsFixed(2),
                  style: theme.textTheme.small.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }),
        if (preview.selections.length > 3 && !isExpanded.value)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Center(
              child: TextButton(
                onPressed: () => isExpanded.value = true,
                child: Text(
                  '+ ${preview.selections.length - 3} more selections',
                  style: theme.textTheme.small.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

        const SizedBox(height: 24),

        // Optional Fields
        Text(
          'Stake Amount',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ShadInput(
          controller: stakeController,
          keyboardType: TextInputType.number,
          placeholder: const Text('e.g., 1000'),
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '₦',
              style: theme.textTheme.small.copyWith(
                color: colorScheme.mutedForeground,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Description',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ShadInput(
          controller: descriptionController,
          placeholder: const Text('e.g., Dorime funds'),
        ),
      ],
    );
  }
}
