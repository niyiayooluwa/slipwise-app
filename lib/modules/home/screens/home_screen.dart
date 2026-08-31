import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/providers/user_notifier.dart';
import 'package:slipwise/core/ui/ticket_card.dart';
import 'package:slipwise/core/ui/theme_gradients.dart';
import 'package:slipwise/core/ui/empty_state_widget.dart';
import 'package:slipwise/core/ui/error_state_widget.dart';
import 'package:slipwise/modules/tickets/providers/filtered_tickets_provider.dart';
import 'package:slipwise/modules/tickets/providers/ticket_controller.dart';
import 'package:slipwise/modules/notifications/providers/notification_controller.dart';
import 'package:slipwise/core/hooks/use_smart_polling.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    final ticketAsync = ref.watch(ticketControllerProvider);
    final pendingCount = ref.watch(pendingTicketsCountProvider);

    final scrollController = useScrollController();

    // Show errors as SnackBar
    ref.listen(ticketControllerProvider, (previous, next) {
      next.when(
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString().replaceFirst('Exception: ', '')),
              backgroundColor: Colors.red,
            ),
          );
        },
        data: (_) {},
        loading: () {},
      );
    });

    // Setup scroll listener for pagination
    useEffect(() {
      void listener() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          final controller = ref.read(ticketControllerProvider.notifier);
          if (controller.hasMorePages && !controller.isLoadingMore) {
            controller.loadMore();
          }
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    // Conditional Polling: Only poll if there are pending/live tickets
    final shouldPoll =
        ticketAsync.value?.any((t) => t.overallStatus == 'pending') ?? false;

    // Setup smart polling timer
    useSmartPolling(
      fetchUpdates: () =>
          ref.read(ticketControllerProvider.notifier).fetchUpdates(),
      shouldPoll: shouldPoll,
    );

    final userAsync = ref.watch(userProvider);
    final unreadCount =
        ref
            .watch(notificationControllerProvider)
            .value
            ?.where((n) => !n.isRead)
            .length ??
        0;
    final username = userAsync.value?.username ?? 'there';
    final profileUrl = 'https://api.dicebear.com/10.x/blobs/svg?seed=$username';
    final today = DateFormat('EEE, MMM d').format(DateTime.now());

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              gradient: ThemeGradients.primaryBackground(context),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Row: Date, Greeting, Icons
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Left Side
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  today,
                                  style: theme.textTheme.muted.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Hello, @$username',
                                  style: theme.textTheme.large.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Right Side (Icons)
                          Row(
                            crossAxisAlignment: .end,
                            children: [
                              // Notification Icon
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        LucideIcons.bell,
                                        size: 20,
                                      ),
                                      onPressed: () =>
                                          context.push('/notifications'),
                                      color: Colors.white,
                                      constraints: const BoxConstraints(
                                        minWidth: 20,
                                        minHeight: 20,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                  if (unreadCount > 0)
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.redAccent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              // Profile Avatar
                              Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: colorScheme.primary.withValues(
                                      alpha: 0.5,
                                    ),
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: SvgPicture.network(
                                    profileUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Pending Tickets Header
                      if (ticketAsync.hasValue &&
                          !ticketAsync.hasError &&
                          !ticketAsync.isLoading) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Recent Tickets',
                                  style: theme.textTheme.large.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (pendingCount > 0) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      '$pendingCount',
                                      style: theme.textTheme.small.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                context.replace('/history');
                              },
                              child: Text(
                                'See All',
                                style: theme.textTheme.small.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Tickets List with Pull-to-Refresh
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await ref
                          .read(ticketControllerProvider.notifier)
                          .refresh();
                    },
                    color: colorScheme.primary,
                    child: ticketAsync.when(
                      data: (tickets) {
                        if (tickets.isEmpty) {
                          return EmptyStateWidget(
                            title: 'No tickets yet',
                            message: 'Track your first ticket to see it here',
                            buttonText: 'Track a Ticket',
                            onButtonPressed: () {
                              context.go('/track');
                            },
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: tickets.length + 1,
                          itemBuilder: (context, index) {
                            if (index == tickets.length) {
                              final controller = ref.watch(
                                ticketControllerProvider.notifier,
                              );
                              return controller.hasMorePages
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Center(
                                        child: SpinKitThreeBounce(
                                          size: 16,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 80);
                            }

                            final ticket = tickets[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
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
                                    extra: ticket,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      loading: () => Center(
                        child: SpinKitThreeBounce(
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      error: (error, stack) => ErrorStateWidget(
                        error: error,
                        onRetry: () {
                          ref.invalidate(ticketControllerProvider);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Map status string to enum
  Status _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'won':
        return Status.won;
      case 'lost':
        return Status.lost;
      case 'pending':
      default:
        return Status.pending;
    }
  }
}
