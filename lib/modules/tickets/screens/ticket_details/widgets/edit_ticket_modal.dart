import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/toast_utils.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/tickets/data/models/update_ticket.dart';
import 'package:slipwise/modules/tickets/providers/history_controller.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';

class EditTicketModal extends HookConsumerWidget {
  final HistoryItem ticket;
  final ValueChanged<HistoryItem> onSaved;

  const EditTicketModal({
    super.key,
    required this.ticket,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    final stakeController = useTextEditingController(
      text: ticket.stake != null && ticket.stake! > 0
          ? ticket.stake.toString()
          : '',
    );
    final descriptionController = useTextEditingController(
      text: ticket.description ?? '',
    );
    final isSaving = useState(false);

    Future<void> handleSave() async {
      final stakeText = stakeController.text.trim();
      final description = descriptionController.text.trim();

      final stake = stakeText.isEmpty
          ? 0.0
          : (double.tryParse(stakeText) ?? 0.0);

      isSaving.value = true;
      try {
        final updateReq = UpdateTicketRequest(
          stake: stake,
          description: description,
        );

        final result = await ref
            .read(ticketRepositoryProvider)
            .updateTicket(ticket.ticketId, updateReq);

        result.fold(
          ifLeft: (error) {
            context.showErrorToast(
              title: 'Failed to update ticket',
              description: error.message,
            );
          },
          ifRight: (messageResp) {
            // Optimistically update the ticket
            final updatedTicket = ticket.copyWith(
              stake: stake,
              description: description,
            );

            onSaved(updatedTicket);

            // Silently refresh the pending and other lists
            // Assuming the ticket could be in any tab, we can refresh the pending ones
            // or just invalidate the providers so they fetch on next focus.
            ref.invalidate(historyControllerProvider);

            context.showToast(
              title: 'Success',
              description: 'Ticket updated successfully',
            );

            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        );
      } catch (e) {
        if (context.mounted) {
          context.showErrorToast(
            title: 'Error',
            description: 'An unexpected error occurred.',
          );
        }
      } finally {
        isSaving.value = false;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Ticket',
                  style: theme.textTheme.h4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.x, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              'Stake Amount',
              style: theme.textTheme.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ShadInput(
              controller: stakeController,
              keyboardType: TextInputType.number,
              placeholder: const Text('0.00'),
              leading: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text('₦', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Description',
              style: theme.textTheme.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ShadInput(
              controller: descriptionController,
              placeholder: const Text('e.g. This one in the bag'),
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            ShadButton(
              size: ShadButtonSize.lg,
              width: double.infinity,
              onPressed: isSaving.value ? null : handleSave,
              child: isSaving.value
                  ? const SpinKitThreeBounce(size: 16, color: Colors.white)
                  : const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
