import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slipwise/core/utils/validators.dart' as validators;
import 'package:slipwise/modules/auth/providers/utility_notifier.dart';
import 'package:slipwise/modules/profile/providers/profile_controller.dart';

class PersonalInfoModal extends HookConsumerWidget {
  final String currentUsername;
  final String currentEmail;

  const PersonalInfoModal({
    super.key,
    required this.currentUsername,
    required this.currentEmail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final controller = useTextEditingController(text: currentUsername);
    final isSubmitting = useState(false);
    final usernameState = useState(currentUsername);

    final status = ref.watch(utilityProvider);
    final isChecking = status is UsernameCheckLoading;
    final isAvailable = status is UsernameCheckAvailable;

    final debounce = useRef<Timer?>(null);

    useEffect(() {
      return () => debounce.value?.cancel();
    }, const []);

    void onUsernameChanged(String value) {
      usernameState.value = value;
      ref.read(utilityProvider.notifier).reset();

      debounce.value?.cancel();

      final localError = validators.validateUsername(value);
      if (localError != null ||
          value.trim().isEmpty ||
          value == currentUsername) {
        return;
      }

      debounce.value = Timer(const Duration(milliseconds: 1000), () {
        ref.read(utilityProvider.notifier).checkUsername(value.trim());
      });
    }

    final localError = validators.validateUsername(usernameState.value);

    // It's valid if it passes local validation AND is available from API
    // Or if they haven't changed it at all (though the button will be disabled if not changed)
    final isValid =
        usernameState.value.trim().isNotEmpty &&
        usernameState.value.trim() != currentUsername &&
        localError == null &&
        isAvailable;

    Widget buildAvailabilityDisplay() {
      if (usernameState.value == currentUsername ||
          usernameState.value.isEmpty) {
        return const SizedBox.shrink();
      }

      if (localError != null) {
        return Text(
          localError,
          style: theme.textTheme.small.copyWith(
            color: theme.colorScheme.destructive,
          ),
        );
      }

      return switch (status) {
        UsernameCheckIdle() => const SizedBox.shrink(),
        UsernameCheckLoading() => Row(
          children: [
            SpinKitThreeBounce(size: 12, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text('Checking availability...', style: theme.textTheme.small),
          ],
        ),
        UsernameCheckAvailable() => Text(
          'Username is available!',
          style: theme.textTheme.small.copyWith(color: Colors.green),
        ),
        UsernameCheckError(message: final msg) => Text(
          msg,
          style: theme.textTheme.small.copyWith(
            color: theme.colorScheme.destructive,
          ),
        ),
      };
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ShadInputFormField(
          label: const Text('Username'),
          controller: controller,
          onChanged: onUsernameChanged,
          description: buildAvailabilityDisplay(),
        ),
        const SizedBox(height: 16),
        ShadInputFormField(
          label: const Text('Email'),
          initialValue: currentEmail,
          enabled: false,
          description: const Text('Email cannot be changed.'),
        ),
        const SizedBox(height: 32),
        ShadButton(
          enabled: isValid && !isSubmitting.value && !isChecking,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            isSubmitting.value = true;

            final error = await ref
                .read(profileControllerProvider.notifier)
                .updateProfile(controller.text.trim());

            isSubmitting.value = false;

            if (context.mounted) {
              if (error == null) {
                Navigator.pop(context);
                ShadToaster.of(context).show(
                  const ShadToast(
                    title: Text('Success'),
                    description: Text('Profile updated successfully.'),
                  ),
                );
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
              ? const SpinKitThreeBounce(size: 16, color: Colors.white)
              : const Text('Save Changes'),
        ),
      ],
    );
  }
}
