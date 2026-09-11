import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/tickets/providers/history_filter_provider.dart';

class HistoryFilterBottomSheet extends HookConsumerWidget {
  const HistoryFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final scheme = theme.colorScheme;
    final currentFilter = ref.watch(historyFilterStateProvider);

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: scheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.muted,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Advanced Filters',
            style: theme.textTheme.h4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCutsChips(context, currentFilter, ref, theme),
                  const SizedBox(height: 24),
                  _buildOddsRange(context, currentFilter, ref, theme),
                  const SizedBox(height: 24),
                  _buildStakeRange(context, currentFilter, ref, theme),
                  const SizedBox(height: 24),
                  _buildDateRange(context, currentFilter, ref, theme),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ShadButton.outline(
                  onPressed: () {
                    ref.read(historyFilterStateProvider.notifier).clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ShadButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCutsChips(
    BuildContext context,
    TicketFilter filter,
    WidgetRef ref,
    ShadThemeData theme,
  ) {
    final scheme = theme.colorScheme;
    final currentCuts = filter.cuts ?? 0;
    final chipOptions = [
      {'val': 0, 'label': 'All'},
      {'val': 1, 'label': '1 Cut'},
      {'val': 2, 'label': '2 Cut'},
      {'val': 3, 'label': '3 Cut'},
      {'val': 4, 'label': '4+ Cut'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuts Filter (Lost Matches)',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          'Filter tickets by number of lost legs',
          style: theme.textTheme.muted.copyWith(fontSize: 11),
        ),
        const SizedBox(height: 12),
        Row(
          children: chipOptions.map((opt) {
            final val = opt['val'] as int;
            final label = opt['label'] as String;
            final isSelected = currentCuts == val;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(historyFilterStateProvider.notifier)
                        .updateFilter(
                          filter.copyWith(
                            cuts: val == 0 ? null : val,
                            clearCuts: val == 0,
                          ),
                        );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? scheme.primary : scheme.card,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? scheme.primary : scheme.border,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.small.copyWith(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? scheme.primaryForeground
                            : scheme.foreground,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOddsRange(
    BuildContext context,
    TicketFilter filter,
    WidgetRef ref,
    ShadThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Odds Range',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ShadInput(
                placeholder: const Text('Min'),
                keyboardType: TextInputType.number,
                initialValue: filter.minOdds?.toString() ?? '',
                onChanged: (val) {
                  final parsed = double.tryParse(val);
                  ref
                      .read(historyFilterStateProvider.notifier)
                      .updateFilter(
                        filter.copyWith(
                          minOdds: parsed,
                          clearMinOdds: parsed == null,
                        ),
                      );
                },
              ),
            ),
            const SizedBox(width: 16),
            const Text('-'),
            const SizedBox(width: 16),
            Expanded(
              child: ShadInput(
                placeholder: const Text('Max'),
                keyboardType: TextInputType.number,
                initialValue: filter.maxOdds?.toString() ?? '',
                onChanged: (val) {
                  final parsed = double.tryParse(val);
                  ref
                      .read(historyFilterStateProvider.notifier)
                      .updateFilter(
                        filter.copyWith(
                          maxOdds: parsed,
                          clearMaxOdds: parsed == null,
                        ),
                      );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStakeRange(
    BuildContext context,
    TicketFilter filter,
    WidgetRef ref,
    ShadThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stake Amount (₦)',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ShadInput(
                placeholder: const Text('Min'),
                keyboardType: TextInputType.number,
                initialValue: filter.minStake?.toString() ?? '',
                onChanged: (val) {
                  final parsed = double.tryParse(val);
                  ref
                      .read(historyFilterStateProvider.notifier)
                      .updateFilter(
                        filter.copyWith(
                          minStake: parsed,
                          clearMinStake: parsed == null,
                        ),
                      );
                },
              ),
            ),
            const SizedBox(width: 16),
            const Text('-'),
            const SizedBox(width: 16),
            Expanded(
              child: ShadInput(
                placeholder: const Text('Max'),
                keyboardType: TextInputType.number,
                initialValue: filter.maxStake?.toString() ?? '',
                onChanged: (val) {
                  final parsed = double.tryParse(val);
                  ref
                      .read(historyFilterStateProvider.notifier)
                      .updateFilter(
                        filter.copyWith(
                          maxStake: parsed,
                          clearMaxStake: parsed == null,
                        ),
                      );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRange(
    BuildContext context,
    TicketFilter filter,
    WidgetRef ref,
    ShadThemeData theme,
  ) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final dateStr = filter.dateRange != null
        ? '${dateFormat.format(filter.dateRange!.start)} - ${dateFormat.format(filter.dateRange!.end)}'
        : 'Select date range';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final picked = await showModalBottomSheet<ShadDateTimeRange>(
              context: context,
              backgroundColor: theme.colorScheme.background,
              isScrollControlled: true,
              builder: (context) {
                var tempRange = filter.dateRange != null
                    ? ShadDateTimeRange(
                        start: filter.dateRange!.start,
                        end: filter.dateRange!.end,
                      )
                    : null;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.muted,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text('Select Date Range', style: theme.textTheme.h4),
                          const SizedBox(height: 16),
                          ShadCalendar.range(
                            selected: tempRange,
                            onChanged: (v) => setState(() => tempRange = v),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: ShadButton.outline(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ShadButton(
                                  onPressed: () =>
                                      Navigator.pop(context, tempRange),
                                  child: const Text('Confirm'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            );

            if (picked != null && picked.start != null) {
              final end = picked.end ?? picked.start!;
              ref
                  .read(historyFilterStateProvider.notifier)
                  .updateFilter(
                    filter.copyWith(
                      dateRange: DateTimeRange(start: picked.start!, end: end),
                    ),
                  );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.input),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateStr,
                  style: theme.textTheme.small.copyWith(
                    color: filter.dateRange != null
                        ? theme.colorScheme.foreground
                        : theme.colorScheme.mutedForeground,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: theme.colorScheme.mutedForeground,
                ),
              ],
            ),
          ),
        ),
        if (filter.dateRange != null)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ref
                    .read(historyFilterStateProvider.notifier)
                    .updateFilter(filter.copyWith(clearDateRange: true));
              },
              child: const Text('Clear date', style: TextStyle(fontSize: 12)),
            ),
          ),
      ],
    );
  }
}
