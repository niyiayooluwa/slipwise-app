import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';
import 'package:slipwise/modules/tickets/screens/ticket_details/ticket_details_screen.dart';

class TicketDetailsLoaderScreen extends HookConsumerWidget {
  final String ticketId;

  const TicketDetailsLoaderScreen({
    super.key,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    
    // We fetch recent tickets to find the metadata for this ticket ID.
    // If we had a specific /v1/tickets/{id}/metadata endpoint, we'd use that instead.
    final fetchTicket = useMemoized(() async {
      final repo = ref.read(ticketRepositoryProvider);
      final result = await repo.getTickets(limit: 50);
      return result.fold(
        ifLeft: (err) => throw Exception(err.message),
        ifRight: (resp) {
          final ticket = resp.data.where((t) => t.ticketId == ticketId).firstOrNull;
          if (ticket == null) {
            throw Exception('Ticket not found');
          }
          return ticket;
        },
      );
    }, [ticketId]);

    final future = useFuture(fetchTicket);

    if (future.connectionState == ConnectionState.waiting) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (future.hasError || !future.hasData) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Could not load ticket details', style: theme.textTheme.large),
              const SizedBox(height: 8),
              Text(future.error?.toString() ?? 'Ticket not found', style: theme.textTheme.muted),
            ],
          ),
        ),
      );
    }

    return TicketDetailsScreen(initialTicket: future.data!);
  }
}
