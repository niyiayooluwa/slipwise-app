import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slipwise/core/utils/validators.dart' as validators;
import 'package:slipwise/modules/auth/screens/register/controller/utility_notifier.dart';
import 'package:slipwise/modules/auth/screens/shared/auth_error_listener.dart';
import 'set_username_controller.dart';

class SetUsernameScreen extends HookConsumerWidget {
  const SetUsernameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final status = ref.watch(utilityProvider);
    final isSubmitting = ref.watch(setUsernameControllerProvider).isLoading;
    final usernameController = useTextEditingController();
    final usernameState = useState('');

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

    final isUsernameValid =
        validators.validateUsername(usernameState.value) == null;
    final canContinue =
        !isChecking && isUsernameValid && isAvailable && !isSubmitting;

    return AuthErrorListener<void>(
      provider: setUsernameControllerProvider,
      errorTitle: 'Failed to set username',
      onSuccess: (context, state) {
        context.go('/home');
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  "Pick a username",
                  style: theme.textTheme.h2.copyWith(height: 1.2),
                ),
                const SizedBox(height: 16),
                Text(
                  "This is how others will see you.",
                  style: theme.textTheme.muted.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
                const SizedBox(height: 48),
                Expanded(
                  child: ShadForm(
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
                          validator: (_) =>
                              validators.validateUsername(usernameState.value),
                        ),
                        const Spacer(),
                        ShadButton(
                          width: double.infinity,
                          size: ShadButtonSize.lg,
                          enabled: canContinue,
                          onPressed: canContinue
                              ? () {
                                  ref
                                      .read(
                                        setUsernameControllerProvider.notifier,
                                      )
                                      .setUsername(
                                        usernameController.text.trim(),
                                      );
                                }
                              : null,
                          child: isSubmitting
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
