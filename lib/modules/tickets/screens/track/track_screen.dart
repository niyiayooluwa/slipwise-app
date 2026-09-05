import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:slipwise/core/utils/toast_utils.dart';
import 'package:slipwise/modules/tickets/providers/track_form_controller.dart';
import 'package:slipwise/core/ui/gradient_sliver_app_bar.dart';
import 'package:slipwise/modules/tickets/screens/track/widgets/track_input_form.dart';
import 'package:slipwise/modules/tickets/screens/track/widgets/track_preview_card.dart';

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

    useListenable(codeController);
    useListenable(stakeController);
    useListenable(descriptionController);

    // State
    final formState = ref.watch(trackFormControllerProvider);
    final formNotifier = ref.read(trackFormControllerProvider.notifier);
    final selectedProvider = useState<String>('SPORTYBET');

    // Listen for errors from preview/track actions
    ref.listen(trackFormControllerProvider.select((s) => s.errorMessage), (
      previous,
      next,
    ) {
      if (next != null) {
        context.showErrorToast(
          title: formState.isTimeout ? 'Timeout' : 'Error',
          description: next,
        );
      }
    });

    ref.listen(trackFormControllerProvider.select((s) => s.isSuccess), (
      previous,
      next,
    ) {
      if (next == true) {
        context.showToast(
          title: 'Success',
          description: 'Ticket tracked successfully!',
        );
        formNotifier.resetSuccess();
        if (context.mounted) {
          context.go('/home');
        }
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          const GradientSliverAppBar(title: 'Track Ticket'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  if (formState.previewResponse == null) ...[
                    // STEP 1: Input Form
                    TrackInputForm(
                      theme: theme,
                      colorScheme: colorScheme,
                      codeController: codeController,
                      selectedProvider: selectedProvider.value,
                      onProviderSelected: (val) {
                        if (val != null) selectedProvider.value = val;
                      },
                      errorMessage: formState.errorMessage,
                      onClearError: formNotifier.clearError,
                    ),

                    const SizedBox(height: 24),

                    ShadButton(
                      size: ShadButtonSize.lg,
                      width: double.infinity,
                      enabled:
                          !formState.isPreviewing &&
                          !formState.isSuccess &&
                          codeController.text.trim().isNotEmpty,
                      onPressed: () => formNotifier.previewTicket(
                        codeController.text.trim(),
                        selectedProvider.value,
                      ),
                      child: formState.isPreviewing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: SpinKitThreeBounce(
                                size: 16,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Preview Ticket'),
                    ),
                  ] else ...[
                    // STEP 2: Preview & Track
                    TrackPreviewCard(
                      theme: theme,
                      colorScheme: colorScheme,
                      preview: formState.previewResponse!,
                      stakeController: stakeController,
                      descriptionController: descriptionController,
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: ShadButton.outline(
                            size: ShadButtonSize.lg,
                            onPressed: () {
                              formNotifier.clearPreview();
                            },
                            child: const Text('Back'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ShadButton(
                            size: ShadButtonSize.lg,
                            onPressed:
                                formState.canSubmitTrack(
                                  stake: stakeController.text,
                                  description: descriptionController.text,
                                )
                                ? () => formNotifier.trackTicket(
                                    stakeController.text,
                                    descriptionController.text,
                                  )
                                : null,
                            child: formState.isTracking
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SpinKitThreeBounce(
                                      size: 16,
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
}
