import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/screens/shared/user_notifier.dart';
import 'package:slipwise/modules/home/screens/widgets/ticket_card.dart';
import 'package:slipwise/modules/tickets/screens/shared/filtered_tickets_provider.dart';
import 'package:slipwise/modules/tickets/screens/shared/ticket_controller.dart';

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

    final userAsync = ref.watch(userProvider);
    final username = userAsync.value?.username ?? 'there';
    final profileUrl =
        'https://api.dicebear.com/10.x/glyphs/svg?seed=$username';
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
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.primary.withValues(alpha: 1.0),
                  colorScheme.primary.withValues(alpha: 0.85),
                  colorScheme.primary.withValues(alpha: 0.55),
                  colorScheme.primary.withValues(alpha: 0.25),
                  colorScheme.primary.withValues(alpha: 0.08),
                  colorScheme.primary.withValues(alpha: 0.0),
                ],
                stops: const [0.0, 0.25, 0.45, 0.65, 0.85, 1.0],
              ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: theme.textTheme.h3.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Right Side (Icons)
                          Row(
                            children: [
                              // Notification Icon
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(LucideIcons.bell, size: 20),
                                  onPressed: () {},
                                  color: Colors.white,
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Profile Avatar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: SvgPicture.network(
                                  profileUrl,
                                  width: 40,
                                  height: 40,
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
                                  'Pending Tickets',
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
                                context.push('/tickets');
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
                          return _buildEmptyState(context, theme, colorScheme);
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
                                        child: CircularProgressIndicator(
                                          color: colorScheme.primary,
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
                                  context.push('/tickets/${ticket.ticketId}');
                                },
                              ),
                            );
                          },
                        );
                      },
                      loading: () => Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                        ),
                      ),
                      error: (error, stack) => _buildErrorState(
                        context,
                        theme,
                        colorScheme,
                        error,
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

  // Empty State
  Widget _buildEmptyState(
    BuildContext context,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty State
          SvgPicture.asset(
            'assets/drawables/states/empty_state.svg', // Replace with your actual path
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 24),
          Text(
            'No tickets yet',
            style: theme.textTheme.large.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your first ticket to see it here',
            style: theme.textTheme.muted.copyWith(
              color: colorScheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 24),
          ShadButton(
            onPressed: () {
              context.replace('/track');
            },
            child: const Text('Track a Ticket'),
          ),
        ],
      ),
    );
  }

  // Error State
  Widget _buildErrorState(
    BuildContext context,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
    Object error, {
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/drawables/states/no_data.svg', // Replace with your actual path
            width: 160,
            height: 160,
          ),
          const SizedBox(height: 24),
          Text(
            'Oops! Something went wrong',
            style: theme.textTheme.large.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error.toString().replaceFirst('Exception: ', ''),
              textAlign: TextAlign.center,
              style: theme.textTheme.muted.copyWith(
                color: colorScheme.mutedForeground,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ShadButton(onPressed: onRetry, child: const Text('Retry')),
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
