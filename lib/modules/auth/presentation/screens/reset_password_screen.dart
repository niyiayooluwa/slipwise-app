import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/presentation/hooks/reset_password_hook.dart';
import 'package:slipwise/modules/auth/providers/notifier/reset_password_notifier.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final form = useResetPasswordForm();
    final authState = ref.watch(resetPasswordProvider);
    final isLoading = authState.isLoading;

    ref.listen(resetPasswordProvider, (previous, next) {
      if (next is AsyncError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Reset Failed'),
            description: Text(next.error.toString()),
          ),
        );
      } else if (next is AsyncData &&
          !next.isLoading &&
          previous?.isLoading == true) {
        ShadToaster.of(context).show(
          const ShadToast(
            title: Text('Password Reset'),
            description: Text(
              'Your password has been successfully reset. Please log in.',
            ),
          ),
        );
        // The instructions say to route immediately to login
        context.go('/login');
      }
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      resizeToAvoidBottomInset: false,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _top(context),
              const SizedBox(height: 32),
              _resetPasswordForm(context, ref, isLoading, form),
            ],
          ),
        ),
      ),
    );
  }

  Widget _top(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Reset Password', style: theme.textTheme.h2.copyWith(height: 1.2)),
        const SizedBox(height: 8),
        Text(
          'Enter the 6-digit code sent to $email and choose a new password.',
          style: theme.textTheme.muted.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _resetPasswordForm(
    BuildContext context,
    WidgetRef ref,
    bool isLoading,
    ResetPasswordFormState form,
  ) {
    return Expanded(
      // 1. Expanded goes OUTSIDE, so it's a direct child of the Column
      child: ShadForm(
        // 2. ShadForm goes inside Expanded
        key: form.formKey,
        child: PageView(
          controller: form.pageController,
          clipBehavior:
              Clip.none, // Prevents the left/right focus ring clipping
          //physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStep1(context, form),
            _buildStep2(context, ref, isLoading, form),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1(BuildContext context, ResetPasswordFormState form) {
    return Column(
      children: [
        ShadInputOTPFormField(
          id: 'otp',
          maxLength: 6,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z0-9]+')),
          ],
          keyboardType: TextInputType.number,
          onChanged: (v) => form.otpController.text = v,
          validator: (v) {
            if (v.contains(' ')) return 'Fill the whole OTP code';
            return null;
          },
          children: const [
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
            Icon(size: 24, LucideIcons.dot),
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        ValueListenableBuilder(
          valueListenable: form.isStep1Valid,
          builder: (context, isValid, _) {
            return ShadButton(
              enabled: isValid,
              onPressed: !isValid
                  ? null
                  : () {
                      form.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
              width: double.infinity,
              child: const Text('Next'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStep2(
    BuildContext context,
    WidgetRef ref,
    bool isLoading,
    ResetPasswordFormState form,
  ) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: form.isPasswordVisible,
          builder: (context, isVisible, _) {
            return ShadInputFormField(
              id: 'password',
              label: const Text('New Password'),
              placeholder: const Text('Enter new password'),
              controller: form.passwordController,
              obscureText: !isVisible,
              trailing: GestureDetector(
                onTap: () => form.isPasswordVisible.value = !isVisible,
                child: Icon(
                  isVisible ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                ),
              ),
              validator: (v) {
                if (v.isEmpty) return 'Password is required';
                if (v.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            );
          },
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: form.isConfirmPasswordVisible,
          builder: (context, isVisible, _) {
            return ShadInputFormField(
              id: 'confirm_password',
              label: const Text('Confirm Password'),
              placeholder: const Text('Re-enter new password'),
              controller: form.confirmPasswordController,
              obscureText: !isVisible,
              trailing: GestureDetector(
                onTap: () => form.isConfirmPasswordVisible.value = !isVisible,
                child: Icon(
                  isVisible ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                ),
              ),
              validator: (v) {
                if (v != form.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            );
          },
        ),
        const SizedBox(height: 32),
        ValueListenableBuilder(
          valueListenable: form.isStep2Valid,
          builder: (context, isValid, _) {
            return ShadButton(
              enabled: isValid && !isLoading,
              onPressed: isLoading || !isValid
                  ? null
                  : () {
                      if (form.formKey.currentState!.saveAndValidate()) {
                        ref
                            .read(resetPasswordProvider.notifier)
                            .resetPassword(
                              email: email,
                              code: form.otpController.text.trim(),
                              newPassword: form.passwordController.text,
                            );
                      }
                    },
              width: double.infinity,
              child: isLoading
                  ? const SizedBox(
                      child: SpinKitThreeBounce(size: 16, color: Colors.white),
                    )
                  : const Text('Reset Password'),
            );
          },
        ),
      ],
    );
  }
}
