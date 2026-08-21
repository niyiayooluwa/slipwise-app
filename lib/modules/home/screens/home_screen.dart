import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          final controller = ref.read(ticketControllerProvider.notifier);
          if (controller.hasMorePages && !controller.isLoadingMore) {
            controller.loadMore();
          }
        }
      });
      return null;
    }, [scrollController]);

    const mockUsername = 'niyi';
    final profileUrl =
        'https://api.dicebear.com/10.x/glyphs/svg?seed=$mockUsername';

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
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
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Side
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wed, Aug 21',
                                  style: theme.textTheme.muted,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Hello, @$mockUsername',
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
                              // Search / Notification Icon with circular dark background
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

                              // Profile Avatar with online indicator
                              /*CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black.withOpacity(0.3),
                            backgroundImage: SvgPicture.network(profileUrl),
                          ),*/
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pending Tickets',
                            style: theme.textTheme.large.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'See All',
                              style: theme.textTheme.small.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /*SingleChildScrollView(
                    child: Column(
                      children: [
                        TicketCard(
                          ticketId: 'TICKET',
                          bookingCode: 'ABC123',
                          betAmount: 200,
                          trackedAt: DateTime.timestamp().startOfWeek,
                          description: 'Sample ticket description',
                          totalOdds: 447,
                          provider: 'Sportybet',
                          status: Status.won,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),*/
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TicketCard(
                          ticketId: 'TICKET',
                          bookingCode: 'ABC123',
                          betAmount: 200,
                          trackedAt: DateTime.timestamp().startOfWeek,
                          description: 'Sample ticket description',
                          totalOdds: 447,
                          provider: 'Sportybet',
                          status: Status.won,
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
