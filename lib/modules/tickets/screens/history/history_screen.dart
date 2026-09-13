import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/ui/app_confirmation_dialog.dart';
import 'package:slipwise/core/ui/ticket_card.dart';
import 'package:slipwise/core/utils/toast_utils.dart';
import 'package:slipwise/modules/tickets/providers/history_controller.dart';
import 'package:slipwise/modules/tickets/providers/history_filter_provider.dart';
import 'package:slipwise/modules/tickets/providers/ticket_selection_provider.dart';
import 'package:slipwise/modules/tickets/screens/history/widgets/history_filter_bottom_sheet.dart';
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
    final filter = ref.watch(historyFilterStateProvider);
    final hasActiveFilter = !filter.isEmpty;
    final selectedIds = ref.watch(ticketSelectionProvider);
    final isSelectionMode = selectedIds.isNotEmpty;

    return PopScope(
      canPop: !isSelectionMode,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isSelectionMode) {
          ref.read(ticketSelectionProvider.notifier).clear();
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: isSelectionMode
            ? AppBar(
                backgroundColor: colorScheme.card,
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: IconButton(
                  icon: Icon(
                    LucideIcons.x,
                    size: 20,
                    color: colorScheme.foreground,
                  ),
                  onPressed: () =>
                      ref.read(ticketSelectionProvider.notifier).clear(),
                ),
                title: Text(
                  '${selectedIds.length} selected',
                  style: theme.textTheme.h4.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.foreground,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton.icon(
                      onPressed: () {
                        final currentTickets =
                            ref
                                .read(
                                  filteredHistoryProvider(selectedTab.value),
                                )
                                .value ??
                            [];
                        ref
                            .read(ticketSelectionProvider.notifier)
                            .selectAll(currentTickets.map((t) => t.ticketId));
                      },
                      icon: Icon(
                        LucideIcons.checkCheck,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                      label: Text(
                        'Select All',
                        style: theme.textTheme.small.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : AppBar(
                title: Text(
                  'History',
                  style: theme.textTheme.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.foreground,
                  ),
                ),
                backgroundColor: colorScheme.background,
                elevation: 0,
                scrolledUnderElevation: 0,
                centerTitle: false,
              ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
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
                                (val) {
                                  selectedTab.value = val;
                                  ref
                                      .read(ticketSelectionProvider.notifier)
                                      .clear();
                                },
                                theme,
                              ),
                              const SizedBox(width: 8),
                              _buildFilterChip(
                                'PENDING',
                                'Active',
                                selectedTab.value,
                                (val) {
                                  selectedTab.value = val;
                                  ref
                                      .read(ticketSelectionProvider.notifier)
                                      .clear();
                                },
                                theme,
                              ),
                              const SizedBox(width: 8),
                              _buildFilterChip(
                                'WON',
                                'Won',
                                selectedTab.value,
                                (val) {
                                  selectedTab.value = val;
                                  ref
                                      .read(ticketSelectionProvider.notifier)
                                      .clear();
                                },
                                theme,
                              ),
                              const SizedBox(width: 8),
                              _buildFilterChip(
                                'LOST',
                                'Lost',
                                selectedTab.value,
                                (val) {
                                  selectedTab.value = val;
                                  ref
                                      .read(ticketSelectionProvider.notifier)
                                      .clear();
                                },
                                theme,
                              ),
                              const SizedBox(width: 8),
                              _buildFilterChip(
                                'ARCHIVED',
                                'Archived',
                                selectedTab.value,
                                (val) {
                                  selectedTab.value = val;
                                  ref
                                      .read(ticketSelectionProvider.notifier)
                                      .clear();
                                },
                                theme,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: hasActiveFilter
                                  ? colorScheme.primary.withValues(alpha: 0.1)
                                  : colorScheme.card,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: hasActiveFilter
                                    ? colorScheme.primary
                                    : colorScheme.border,
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                LucideIcons.slidersHorizontal,
                                size: 18,
                                color: hasActiveFilter
                                    ? colorScheme.primary
                                    : colorScheme.foreground,
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
                          if (hasActiveFilter)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: colorScheme.background,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (filter.cuts != null && filter.cuts! > 0)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: colorScheme.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.slidersHorizontal,
                                size: 12,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Filtered: ${filter.cuts == 4 ? "4+" : filter.cuts} Cut',
                                style: theme.textTheme.small.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(historyFilterStateProvider.notifier)
                                      .updateFilter(
                                        filter.copyWith(clearCuts: true),
                                      );
                                },
                                child: Icon(
                                  LucideIcons.x,
                                  size: 14,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: IndexedStack(
                    index: selectedTab.value == 'ALL'
                        ? 0
                        : selectedTab.value == 'PENDING'
                        ? 1
                        : selectedTab.value == 'WON'
                        ? 2
                        : selectedTab.value == 'LOST'
                        ? 3
                        : 4,
                    children: const [
                      _TicketList(status: 'ALL'),
                      _TicketList(status: 'PENDING'),
                      _TicketList(status: 'WON'),
                      _TicketList(status: 'LOST'),
                      _TicketList(status: 'ARCHIVED'),
                    ],
                  ),
                ),
              ],
            ),
            if (isSelectionMode)
              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.card,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: colorScheme.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ShadButton.secondary(
                            size: ShadButtonSize.sm,
                            onPressed: () async {
                              final isArchivedTab =
                                  selectedTab.value == 'ARCHIVED';
                              final confirmed = await AppConfirmationDialog.show(
                                context,
                                title: isArchivedTab
                                    ? 'Restore Tickets'
                                    : 'Archive Tickets',
                                description: isArchivedTab
                                    ? 'Restore ${selectedIds.length} ticket(s) back to your active tickets?'
                                    : 'Archive ${selectedIds.length} ticket(s)? They will be moved to the Archived tab and notification alerts will be muted.',
                                confirmText: isArchivedTab
                                    ? 'Restore'
                                    : 'Archive',
                              );
                              if (confirmed == true && context.mounted) {
                                final ids = selectedIds.toList();
                                ref
                                    .read(ticketSelectionProvider.notifier)
                                    .clear();
                                final success = isArchivedTab
                                    ? await ref
                                          .read(
                                            historyControllerProvider(
                                              'ARCHIVED',
                                            ).notifier,
                                          )
                                          .unarchiveTickets(ids)
                                    : await ref
                                          .read(
                                            historyControllerProvider(
                                              selectedTab.value,
                                            ).notifier,
                                          )
                                          .archiveTickets(ids);
                                if (context.mounted) {
                                  if (success) {
                                    AppToast.show(
                                      context,
                                      title: isArchivedTab
                                          ? 'Tickets restored'
                                          : 'Tickets archived',
                                      description: isArchivedTab
                                          ? '${ids.length} ticket(s) restored to active feeds.'
                                          : '${ids.length} ticket(s) moved to Archived tab. Notifications muted.',
                                    );
                                  } else {
                                    AppToast.error(
                                      context,
                                      title: isArchivedTab
                                          ? 'Restore failed'
                                          : 'Archive failed',
                                      description:
                                          'Could not update selected tickets.',
                                    );
                                  }
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  selectedTab.value == 'ARCHIVED'
                                      ? LucideIcons.archiveRestore
                                      : LucideIcons.archive,
                                  size: 16,
                                  color: colorScheme.foreground,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  selectedTab.value == 'ARCHIVED'
                                      ? 'Restore (${selectedIds.length})'
                                      : 'Archive (${selectedIds.length})',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ShadButton.outline(
                            size: ShadButtonSize.sm,
                            onPressed: () async {
                              final confirmed = await AppConfirmationDialog.show(
                                context,
                                title: 'Delete Tickets',
                                description:
                                    'Are you sure you want to delete ${selectedIds.length} ticket(s)? This action cannot be undone.',
                                confirmText: 'Delete',
                                isDestructive: true,
                                disclaimer:
                                    'Note: Deleting a ticket removes it from your feeds, but your overall betting stats, win rates, and profit records will remain preserved.',
                              );
                              if (confirmed == true && context.mounted) {
                                final ids = selectedIds.toList();
                                ref
                                    .read(ticketSelectionProvider.notifier)
                                    .clear();
                                final success = await ref
                                    .read(
                                      historyControllerProvider(
                                        selectedTab.value,
                                      ).notifier,
                                    )
                                    .deleteTickets(ids);
                                if (context.mounted) {
                                  if (success) {
                                    AppToast.show(
                                      context,
                                      title: 'Tickets deleted',
                                      description:
                                          '${ids.length} ticket(s) removed from your feeds.',
                                    );
                                  } else {
                                    AppToast.error(
                                      context,
                                      title: 'Delete failed',
                                      description:
                                          'Could not delete selected tickets.',
                                    );
                                  }
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.trash2,
                                  size: 16,
                                  color: colorScheme.mutedForeground,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Delete (${selectedIds.length})',
                                  style: TextStyle(
                                    color: colorScheme.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
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
    final colorScheme = ShadTheme.of(context).colorScheme;
    final ticketsAsync = ref.watch(filteredHistoryProvider(status));
    final controller = ref.watch(historyControllerProvider(status).notifier);

    final selectedIds = ref.watch(ticketSelectionProvider);
    final isSelectionMode = selectedIds.isNotEmpty;

    // Conditional Polling: Only poll if there are pending/live tickets
    final shouldPoll =
        ticketsAsync.value?.any(
          (t) => t.overallStatus.toLowerCase() == 'pending',
        ) ??
        false;

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
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SpinKitThreeBounce(
                        size: 16,
                        color: colorScheme.primary,
                      ),
                    ),
                  );
                }
                final ticket = tickets[index];
                final isSelected = selectedIds.contains(ticket.ticketId);
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
                      totalLegs: ticket.totalLegs,
                      wonLegs: ticket.wonLegs,
                      lostLegs: ticket.lostLegs,
                      pendingLegs: ticket.pendingLegs,
                      isArchived: ticket.isArchived || status == 'ARCHIVED',
                      isSelectionMode: isSelectionMode,
                      isSelected: isSelected,
                      onSelectToggle: () {
                        ref
                            .read(ticketSelectionProvider.notifier)
                            .toggle(ticket.ticketId);
                      },
                      onLongPress: () {
                        if (!isSelectionMode) {
                          ref
                              .read(ticketSelectionProvider.notifier)
                              .select(ticket.ticketId);
                        }
                      },
                      onArchive: () async {
                        final confirmed = await AppConfirmationDialog.show(
                          context,
                          title: 'Archive Ticket',
                          description:
                              'Archive ticket #${ticket.code}? It will be moved to the Archived tab and notification alerts will be muted.',
                          confirmText: 'Archive',
                        );
                        if (confirmed == true && context.mounted) {
                          final success = await ref
                              .read(historyControllerProvider(status).notifier)
                              .archiveTickets([ticket.ticketId]);
                          if (context.mounted) {
                            if (success) {
                              AppToast.show(
                                context,
                                title: 'Ticket archived',
                                description:
                                    'Ticket moved to Archived tab. Notifications muted.',
                              );
                            } else {
                              AppToast.error(
                                context,
                                title: 'Archive failed',
                                description: 'Could not archive ticket.',
                              );
                            }
                          }
                        }
                      },
                      onUnarchive: () async {
                        final confirmed = await AppConfirmationDialog.show(
                          context,
                          title: 'Restore Ticket',
                          description:
                              'Restore ticket #${ticket.code} back to your active tickets?',
                          confirmText: 'Restore',
                        );
                        if (confirmed == true && context.mounted) {
                          final success = await ref
                              .read(historyControllerProvider(status).notifier)
                              .unarchiveTickets([ticket.ticketId]);
                          if (context.mounted) {
                            if (success) {
                              AppToast.show(
                                context,
                                title: 'Ticket restored',
                                description: 'Ticket restored to active feeds.',
                              );
                            } else {
                              AppToast.error(
                                context,
                                title: 'Restore failed',
                                description: 'Could not restore ticket.',
                              );
                            }
                          }
                        }
                      },
                      onDelete: () async {
                        final confirmed = await AppConfirmationDialog.show(
                          context,
                          title: 'Delete Ticket',
                          description:
                              'Are you sure you want to delete ticket #${ticket.code}? This action cannot be undone.',
                          confirmText: 'Delete',
                          isDestructive: true,
                          disclaimer:
                              'Note: Deleting a ticket removes it from your feeds, but your overall betting stats, win rates, and profit records will remain preserved.',
                        );
                        if (confirmed == true && context.mounted) {
                          final success = await ref
                              .read(historyControllerProvider(status).notifier)
                              .deleteTickets([ticket.ticketId]);
                          if (context.mounted) {
                            if (success) {
                              AppToast.show(
                                context,
                                title: 'Ticket deleted',
                                description: 'Ticket removed from feeds.',
                              );
                            } else {
                              AppToast.error(
                                context,
                                title: 'Delete failed',
                                description: 'Could not delete ticket.',
                              );
                            }
                          }
                        }
                      },
                      onTap: () {
                        if (isSelectionMode) {
                          ref
                              .read(ticketSelectionProvider.notifier)
                              .toggle(ticket.ticketId);
                        } else {
                          context.push(
                            '/ticket-details',
                            extra: {
                              'ticket': ticket,
                              'heroTag': 'ticket-${ticket.ticketId}-$status',
                            },
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      loading: () => Center(
        child: SpinKitThreeBounce(size: 16, color: colorScheme.primary),
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
