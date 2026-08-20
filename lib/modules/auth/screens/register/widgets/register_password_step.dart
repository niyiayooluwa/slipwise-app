import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slipwise/core/utils/validators.dart' as validators;
import 'package:slipwise/modules/auth/screens/register/controller/register_form_controller.dart';
import 'package:slipwise/modules/auth/screens/register/controller/register_controller.dart';

class RegisterPasswordStep extends ConsumerWidget {
  final RegisterForm notifier;
  final RegisterFormState form;
  final bool isAnyLoading;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterPasswordStep({
    super.key,
    required this.notifier,
    required this.form,
    required this.isAnyLoading,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadForm(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShadInputFormField(
            controller: passwordController,
            placeholder: const Text("Enter your password"),
            obscureText: form.obscurePassword,
            leading: const Icon(LucideIcons.lock, size: 16),
            onChanged: notifier.setPassword,
            validator: (_) => form.passwordError,
            trailing: InkWell(
              onTap: notifier.togglePasswordVisible,
              child: Icon(
                form.obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
              ),
            ),
          ),
          const SizedBox(height: 12),

          AnimatedBuilder(
            animation: passwordController,
            builder: (context, _) {
              return PasswordRequirements(password: form.password);
            },
          ),
          const SizedBox(height: 16),

          ShadInputFormField(
            controller: confirmPasswordController,
            placeholder: const Text("Confirm your password"),
            obscureText: form.obscureConfirm,
            leading: const Icon(LucideIcons.lock, size: 16),
            onChanged: notifier.setConfirmPassword,
            validator: (_) => form.confirmError,
            trailing: InkWell(
              onTap: notifier.toggleConfirmVisible,
              child: Icon(
                form.obscureConfirm ? LucideIcons.eye : LucideIcons.eyeOff,
              ),
            ),
          ),
          const Spacer(),

          ShadButton(
            width: double.infinity,
            size: ShadButtonSize.lg,
            enabled: !isAnyLoading && form.isFormComplete,
            onPressed: !isAnyLoading && form.isFormComplete
                ? () async {
                    await ref
                        .read(registerControllerProvider.notifier)
                        .signUp(
                          username: form.username.trim(),
                          email: form.email.trim(),
                          password: form.password.trim(),
                        );
                  }
                : null,
            child: isAnyLoading
                ? const SizedBox(
                    child: SpinKitThreeBounce(size: 16, color: Colors.white),
                  )
                : const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final requirements = validators.passwordRequirements(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: requirements.entries.map((entry) {
        final met = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Icon(
                met ? LucideIcons.checkCircle2 : LucideIcons.circle,
                size: 16,
                color: met
                    ? theme.colorScheme.primary
                    : theme.colorScheme.mutedForeground,
              ),
              const SizedBox(width: 8),
              Text(
                entry.key,
                style: theme.textTheme.small.copyWith(
                  color: met
                      ? theme.colorScheme.primary
                      : theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
