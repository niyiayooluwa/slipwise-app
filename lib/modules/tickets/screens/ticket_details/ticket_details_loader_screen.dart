import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/tickets/providers/ticket_detail_controller.dart';
import 'package:slipwise/modules/tickets/screens/ticket_details/ticket_details_screen.dart';

class TicketDetailsLoaderScreen extends HookConsumerWidget {
  final String ticketId;

  const TicketDetailsLoaderScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final ticketAsync = ref.watch(singleTicketProvider(ticketId));

    return ticketAsync.when(
      loading: () => Scaffold(
        body: Center(
          child: SpinKitThreeBounce(size: 24, color: theme.colorScheme.primary),
        ),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Could not load ticket details',
                style: theme.textTheme.large,
              ),
              const SizedBox(height: 8),
              Text(err.toString(), style: theme.textTheme.muted),
            ],
          ),
        ),
      ),
      data: (ticket) => TicketDetailsScreen(initialTicket: ticket),
    );
  }
}
