import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/tickets/providers/ticket_detail_controller.dart';
import 'package:slipwise/modules/tickets/screens/ticket_details/ticket_details_screen.dart';
import 'package:slipwise/core/ui/error_state_widget.dart';

class TicketDetailsLoaderScreen extends HookConsumerWidget {
  final String ticketId;

  const TicketDetailsLoaderScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final ticketAsync = ref.watch(singleTicketProvider(ticketId));

    return ticketAsync.when(
      loading: () => Scaffold(
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
        ),
        body: Center(
          child: SpinKitThreeBounce(size: 24, color: theme.colorScheme.primary),
        ),
      ),
      error: (err, stack) => Scaffold(
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
        ),
        body: ErrorStateWidget(
          error: err,
          onRetry: () => ref.refresh(singleTicketProvider(ticketId)),
        ),
      ),
      data: (ticket) => TicketDetailsScreen(initialTicket: ticket),
    );
  }
}
