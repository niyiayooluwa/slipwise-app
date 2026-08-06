import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/presentation/hooks/register_form_hook.dart';
import 'package:slipwise/modules/auth/providers/notifier/register_notifier.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final form = useRegisterForm();
    final authState = ref.watch(registerProvider);

    ref.listen(registerProvider, (previous, next) {
      if (next is AsyncError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Registration Failed'),
            description: Text(next.error.toString()),
          ),
        );
      } else if (next is AsyncData &&
          !next.isLoading &&
          previous?.isLoading == true) {
        ShadToaster.of(context).show(
          const ShadToast(
            title: Text('Account Created'),
            description: Text('Please check your email for an OTP.'),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            LucideIcons.arrowLeft,
            color: theme.colorScheme.foreground,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ShadForm(
            key: form.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Create an account', style: theme.textTheme.h2),
                const SizedBox(height: 8),
                Text(
                  'Join SlipWise to start tracking',
                  style: theme.textTheme.p.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ShadInput(
                        controller: form.firstNameController,
                        placeholder: const Text('First Name'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ShadInput(
                        controller: form.lastNameController,
                        placeholder: const Text('Last Name'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ShadInput(
                  controller: form.emailController,
                  placeholder: const Text('Email address'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                ShadInput(
                  controller: form.passwordController,
                  placeholder: const Text('Password'),
                  obscureText: !form.isPasswordVisible.value,
                ),
                const SizedBox(height: 16),
                ShadInput(
                  controller: form.confirmPasswordController,
                  placeholder: const Text('Confirm Password'),
                  obscureText: !form.isConfirmPasswordVisible.value,
                ),
                const SizedBox(height: 32),
                ShadButton(
                  size: ShadButtonSize.lg,
                  onPressed: (!form.isFormValid.value || authState.isLoading)
                      ? null
                      : () {
                          ref
                              .read(registerProvider.notifier)
                              .signUp(
                                firstName: form.firstNameController.text.trim(),
                                lastName: form.lastNameController.text.trim(),
                                email: form.emailController.text.trim(),
                                password: form.passwordController.text,
                              );
                        },
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
