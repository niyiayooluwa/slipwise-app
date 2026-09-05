import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/toast_utils.dart';
import 'package:slipwise/modules/profile/providers/profile_controller.dart';

class FeedbackModal extends HookConsumerWidget {
  const FeedbackModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isSubmitting = useState(false);

    // Rebuild when text changes to check length
    useListenable(controller);

    final isValid =
        controller.text.trim().length >= 10 &&
        controller.text.trim().length <= 2000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Tell us what you think! We are constantly trying to improve SlipWise.',
        ),
        const SizedBox(height: 16),
        ShadInputFormField(
          controller: controller,
          maxLines: 5,
          placeholder: const Text('Type your feedback here (min 10 chars)...'),
        ),
        const SizedBox(height: 32),
        ShadButton(
          size: ShadButtonSize.lg,
          width: double.infinity,
          enabled: isValid && !isSubmitting.value,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            isSubmitting.value = true;
            final error = await ref
                .read(profileControllerProvider.notifier)
                .submitFeedback(controller.text.trim());
            isSubmitting.value = false;

            if (context.mounted) {
              if (error == null) {
                Navigator.pop(context);
                context.showToast(
                  title: 'Success',
                  description: 'Thank you for your feedback!',
                );
              } else {
                context.showErrorToast(title: 'Error', description: error);
              }
            }
          },
          child: isSubmitting.value
              ? const SpinKitThreeBounce(size: 16, color: Colors.white)
              : const Text('Send Feedback'),
        ),
      ],
    );
  }
}
