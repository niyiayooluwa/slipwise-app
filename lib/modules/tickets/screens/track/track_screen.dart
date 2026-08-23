import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/tickets/data/models/preview.dart';
import 'package:slipwise/modules/tickets/data/models/track.dart';
import 'package:slipwise/modules/tickets/screens/shared/ticket_action_controller.dart';
import 'package:slipwise/modules/tickets/screens/shared/ticket_controller.dart';

class TrackScreen extends HookConsumerWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    // Form controllers
    final codeController = useTextEditingController();
    final stakeController = useTextEditingController();
    final descriptionController = useTextEditingController();

    // State
    final previewResponse = useState<PreviewResponse?>(null);
    final isPreviewing = useState(false);
    final isTracking = useState(false);

    // Listen for errors from preview/track actions
    ref.listen(ticketActionsProvider, (previous, next) {
      next.when(
        error: (error, stack) {
          final errorMessage = error.toString();

          // Check if it's a timeout error
          if (errorMessage.contains('timeout') ||
              errorMessage.contains('deadline exceeded')) {
            ShadToaster.of(context).show(
              ShadToast(
                title: const Text('Timeout'),
                description: Text(
                  'Sportybet is taking too long to respond. Please try again in a moment.',
                ),
                action: ShadButton.outline(
                  onPressed: () {},
                  child: const Text('Close'),
                ),
              ),
            );
          } else {
            ShadToaster.of(context).show(
              ShadToast(
                title: const Text('Error'),
                description: Text(errorMessage),
                action: ShadButton.outline(
                  onPressed: () {},
                  child: const Text('Close'),
                ),
              ),
            );
          }
        },
        data: (_) {},
        loading: () {},
      );
    });

    Future<void> handlePreview() async {
      if (codeController.text.isEmpty) {
        ShadToaster.of(context).show(
          const ShadToast(
            title: Text('Required'),
            description: Text('Please enter your booking code'),
          ),
        );
        return;
      }

      isPreviewing.value = true;

      try {
        final preview = await ref
            .read(ticketActionsProvider.notifier)
            .previewTicket(
              PreviewRequest(
                code: codeController.text.trim(),
                provider: 'SPORTYBET',
              ),
            );

        if (preview != null) {
          previewResponse.value = preview;
        }
      } catch (e) {
        ShadToaster.of(context).show(
          const ShadToast(
            title: Text('Error'),
            description: Text('Something went wrong. Please try again.'),
          ),
        );
      } finally {
        isPreviewing.value = false;
      }
    }

    Future<void> handleTrack() async {
      final preview = previewResponse.value;
      if (preview == null) return;

      isTracking.value = true;

      try {
        final stake = stakeController.text.isEmpty
            ? null
            : double.tryParse(stakeController.text);

        final description = descriptionController.text.isEmpty
            ? null
            : descriptionController.text.trim();

        final response = await ref
            .read(ticketActionsProvider.notifier)
            .trackTicket(
              TrackRequest(
                bookingCodeId: preview.bookingCodeId,
                stake: stake,
                description: description,
              ),
            );

        if (response != null) {
          // Success
          ShadToaster.of(context).show(
            const ShadToast(
              title: Text('Success'),
              description: Text('Ticket tracked successfully!'),
            ),
          );

          // Refresh ticket list
          ref.invalidate(ticketControllerProvider);

          // Navigate back
          if (context.mounted) {
            context.pop();
          }
        }
      } catch (e) {
        ShadToaster.of(context).show(
          const ShadToast(
            title: Text('Error'),
            description: Text('Something went wrong. Please try again.'),
          ),
        );
      } finally {
        isTracking.value = false;
      }
    }

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140.0,
            pinned: true,
            backgroundColor: colorScheme.background,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.55),
                      colorScheme.primary.withValues(alpha: 0.35),
                      colorScheme.primary.withValues(alpha: 0.25),
                      colorScheme.primary.withValues(alpha: 0.15),
                      colorScheme.primary.withValues(alpha: 0.08),
                      colorScheme.primary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.25, 0.45, 0.65, 0.85, 1.0],
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Track Ticket',
                style: theme.textTheme.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.foreground,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Step indicator
                  _buildStepIndicator(
                    currentStep: previewResponse.value == null ? 1 : 2,
                    colorScheme: colorScheme,
                  ),

                  const SizedBox(height: 32),

                  if (previewResponse.value == null) ...[
                    // STEP 1: Input Form
                    _buildInputForm(theme, colorScheme, codeController),

                    const SizedBox(height: 24),

                    ShadButton(
                      onPressed: isPreviewing.value ? null : handlePreview,
                      child: isPreviewing.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Preview Ticket'),
                    ),
                  ] else ...[
                    // STEP 2: Preview & Track
                    _buildPreviewCard(
                      theme,
                      colorScheme,
                      previewResponse.value!,
                      stakeController,
                      descriptionController,
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: ShadButton.outline(
                            onPressed: () {
                              previewResponse.value = null;
                            },
                            child: const Text('Back'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ShadButton(
                            onPressed: isTracking.value ? null : handleTrack,
                            child: isTracking.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Track Ticket'),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step Indicator
  Widget _buildStepIndicator({
    required int currentStep,
    required ShadColorScheme colorScheme,
  }) {
    return Row(
      children: [
        _buildStep(1, 'Enter Code', currentStep >= 1, colorScheme),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep >= 2 ? colorScheme.primary : colorScheme.muted,
          ),
        ),
        _buildStep(2, 'Preview & Track', currentStep >= 2, colorScheme),
      ],
    );
  }

  Widget _buildStep(
    int step,
    String label,
    bool isActive,
    ShadColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : colorScheme.muted,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive ? Colors.white : colorScheme.mutedForeground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive
                ? colorScheme.foreground
                : colorScheme.mutedForeground,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Step 1: Input Form
  Widget _buildInputForm(
    ShadThemeData theme,
    ShadColorScheme colorScheme,
    TextEditingController codeController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sportybet badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(LucideIcons.info, size: 16, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Only SPORTYBET is supported for now with\n'
                'limited markets',
                style: theme.textTheme.small.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Booking Code',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: codeController,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            hintText: 'e.g., J6J2TN',
            filled: true,
            fillColor: colorScheme.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter the booking code from your Sportybet ticket',
          style: theme.textTheme.small.copyWith(
            color: colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  // Step 2: Preview Card
  Widget _buildPreviewCard(
    ShadThemeData theme,
    ShadColorScheme colorScheme,
    PreviewResponse preview,
    TextEditingController stakeController,
    TextEditingController descriptionController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SPORTYBET',
                    style: theme.textTheme.small.copyWith(
                      color: colorScheme.mutedForeground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '${preview.totalOdds.toStringAsFixed(2)}x',
                      style: theme.textTheme.small.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                preview.code,
                style: theme.textTheme.large.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Selections
        Text(
          'Selections (${preview.selections.length})',
          style: theme.textTheme.large.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...preview.selections.map((selection) {
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
                        '${selection.marketType}: ${selection.selection}',
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

        const SizedBox(height: 24),

        // Optional Fields
        Text(
          'Stake Amount (Optional)',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: stakeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'e.g., 1000',
            prefixText: '₦ ',
            filled: true,
            fillColor: colorScheme.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Description (Optional)',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            hintText: 'e.g., Weekend Acca',
            filled: true,
            fillColor: colorScheme.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
