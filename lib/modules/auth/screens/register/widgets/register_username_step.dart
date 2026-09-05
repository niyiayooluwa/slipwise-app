import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slipwise/core/utils/validators.dart' as validators;
import 'package:slipwise/modules/auth/providers/register_form_controller.dart';
import 'package:slipwise/modules/auth/providers/utility_notifier.dart';

class RegisterUsernameStep extends HookConsumerWidget {
  final RegisterForm notifier;
  final RegisterFormState form;
  final TextEditingController usernameController;

  const RegisterUsernameStep({
    super.key,
    required this.notifier,
    required this.form,
    required this.usernameController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final status = ref.watch(utilityProvider);

    final isChecking = status is UsernameCheckLoading;
    final isAvailable = status is UsernameCheckAvailable;

    // Debounce timer lives across rebuilds, cleaned up on unmount.
    final debounce = useRef<Timer?>(null);

    useEffect(() {
      return () => debounce.value?.cancel();
    }, const []);

    void onUsernameChanged(String value) {
      notifier.setUsername(value);
      ref.read(utilityProvider.notifier).reset();

      debounce.value?.cancel();

      // Don't hit the network for something that already fails local format validation.
      final localError = validators.validateUsername(value);
      if (localError != null || value.trim().isEmpty) return;

      debounce.value = Timer(const Duration(milliseconds: 1000), () {
        ref.read(utilityProvider.notifier).checkUsername(value.trim());
      });
    }

    final display = switch (status) {
      UsernameCheckIdle() => const SizedBox.shrink(),
      UsernameCheckLoading() => Text(
        'Checking availability...',
        style: TextStyle(color: theme.colorScheme.accent, fontSize: 10),
      ),
      UsernameCheckAvailable() => Text(
        'Username is available ✓',
        style: TextStyle(color: theme.colorScheme.primary, fontSize: 10),
      ),
      UsernameCheckError(:final message) => Text(
        message,
        style: TextStyle(
          color: theme.colorScheme.destructiveForeground,
          fontSize: 10,
        ),
      ),
    };

    final canContinue = !isChecking && form.isUsernameValid && isAvailable;

    return ShadForm(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShadInputFormField(
            controller: usernameController,
            placeholder: const Text("username"),
            leading: const Icon(LucideIcons.atSign, size: 16),
            trailing: display,
            maxLength: 16,
            keyboardType: TextInputType.text,
            onChanged: onUsernameChanged,
            validator: (_) => form.usernameError,
          ),
          const Spacer(),
          ShadButton(
            width: double.infinity,
            size: ShadButtonSize.lg,
            enabled: canContinue,
            onPressed: canContinue ? notifier.nextStep : null,
            child: isChecking
                ? const SizedBox(
                    child: SpinKitThreeBounce(
                      size: 16,
                      color: Colors.white,
                    ),
                  )
                : const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
