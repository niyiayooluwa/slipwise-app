import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/profile/providers/profile_controller.dart';

class SecurityModal extends HookConsumerWidget {
  final String email;

  const SecurityModal({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitting = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'To change your password, we will send a verification code to your email.',
        ),
        const SizedBox(height: 32),
        ShadButton(
          enabled: !isSubmitting.value,
          onPressed: () async {
            isSubmitting.value = true;

            final error = await ref
                .read(profileControllerProvider.notifier)
                .forgotPassword(email);

            isSubmitting.value = false;

            if (context.mounted) {
              if (error == null) {
                Navigator.pop(context);
                context.go('/reset-password', extra: email);
              } else {
                ShadToaster.of(context).show(
                  ShadToast(
                    title: const Text('Error'),
                    description: Text(error),
                  ),
                );
              }
            }
          },
          child: isSubmitting.value
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: SpinKitThreeBounce(size: 16, color: Colors.white),
                )
              : const Text('Send Reset Code'),
        ),
      ],
    );
  }
}
