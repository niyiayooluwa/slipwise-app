import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/validators.dart';
import 'package:slipwise/modules/auth/presentation/hooks/register_form_hook.dart';
import 'package:slipwise/modules/auth/providers/notifier/register_notifier.dart';
import 'package:slipwise/modules/auth/providers/notifier/google_auth_notifier.dart';
import 'package:slipwise/modules/auth/providers/notifier/user_notifier.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final authState = ref.watch(registerProvider);
    final isLoading = authState.isLoading;
    final isGoogleLoading = ref.watch(googleAuthProvider).isLoading;
    final isAnyLoading = isLoading || isGoogleLoading;
    final form = useRegisterForm();

    ref.listen(googleAuthProvider, (previous, next) {
      if (next is AsyncError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Google Sign-In Failed'),
            description: Text(next.error.toString()),
          ),
        );
      } else if (next is AsyncData &&
          !next.isLoading &&
          previous?.isLoading == true) {
        if (ref.read(userProvider).value != null) {
          context.go('/home');
        }
      }
    });

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
        context.push('/verify-otp', extra: form.emailController.text.trim());
      }
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _top(context),
              const SizedBox(height: 24),
              _registerForm(context, ref, isAnyLoading, form),
              const SizedBox(height: 24),
              Expanded(child: _bottom(context, ref, isAnyLoading)),
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
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(
            'assets/drawables/logo/white.svg',
            height: 40,
            width: 40,
            semanticsLabel: 'Splash Screen Logo',
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Create an account',
          style: theme.textTheme.h2.copyWith(height: 0.7),
        ),
        const SizedBox(height: 8),
        Text(
          'Join SlipWise to start tracking',
          style: theme.textTheme.muted.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _bottom(BuildContext context, WidgetRef ref, bool isAnyLoading) {
    final theme = ShadTheme.of(context);
    final isGoogleLoading = ref.watch(googleAuthProvider).isLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: theme.textTheme.muted.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),

        ShadButton.outline(
          width: double.infinity,
          leading: isGoogleLoading
              ? null
              : SvgPicture.asset(
                  "assets/drawables/google.svg",
                  height: 18,
                  width: 18,
                ),
          onPressed: isAnyLoading
              ? null
              : () {
                  ref.read(googleAuthProvider.notifier).signIn();
                },
          child: isGoogleLoading
              ? SizedBox(
                  child: SpinKitThreeBounce(
                    size: 16,
                    color: theme.colorScheme.foreground,
                  ),
                )
              : const Text('Continue with Google'),
        ),

        const Spacer(),

        Text.rich(
          TextSpan(
            text: "Already have an account? ",
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            children: [
              TextSpan(
                text: 'Log In',
                style: TextStyle(color: theme.colorScheme.primary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.push('/login');
                  },
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _registerForm(
    BuildContext context,
    WidgetRef ref,
    bool isLoading,
    RegisterFormState form,
  ) {
    final dTheme = Theme.of(context);

    return ShadForm(
      key: form.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ShadInputFormField(
                  id: 'lastName',
                  controller: form.usernameController,
                  label: Text('LAST NAME', style: dTheme.textTheme.labelSmall),
                  placeholder: const Text('Doe'),
                  validator: (v) => v.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ShadInputFormField(
            id: 'email',
            controller: form.emailController,
            label: Text('EMAIL', style: dTheme.textTheme.labelSmall),
            placeholder: const Text('you@example.com'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => validateEmail(value),
          ),
          const SizedBox(height: 16),

          // Password field
          ValueListenableBuilder(
            valueListenable: form.isPasswordVisible,
            builder: (context, isVisible, _) {
              return ShadInputFormField(
                id: 'password',
                controller: form.passwordController,
                label: Text('PASSWORD', style: dTheme.textTheme.labelSmall),
                placeholder: const Text('•••••••••'),
                obscureText: !isVisible,
                validator: (value) => validatePassword(value),
                trailing: GestureDetector(
                  onTap: () => form.isPasswordVisible.value = !isVisible,
                  child: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password field
          ValueListenableBuilder(
            valueListenable: form.isConfirmPasswordVisible,
            builder: (context, isVisible, _) {
              return ShadInputFormField(
                id: 'confirmPassword',
                controller: form.confirmPasswordController,
                label: Text(
                  'CONFIRM PASSWORD',
                  style: dTheme.textTheme.labelSmall,
                ),
                placeholder: const Text('•••••••••'),
                obscureText: !isVisible,
                validator: (v) {
                  if (v.isEmpty) return 'Required';
                  if (v != form.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                trailing: GestureDetector(
                  onTap: () => form.isConfirmPasswordVisible.value = !isVisible,
                  child: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          ValueListenableBuilder(
            valueListenable: form.isFormValid,
            builder: (context, isValid, _) {
              return ShadButton(
                enabled: isValid && !isLoading,
                onPressed: isLoading || !isValid
                    ? null
                    : () {
                        if (form.formKey.currentState!.saveAndValidate()) {
                          ref
                              .read(registerProvider.notifier)
                              .signUp(
                                username: form.usernameController.text.trim(),
                                email: form.emailController.text.trim(),
                                password: form.passwordController.text,
                              );
                        }
                      },
                width: double.infinity,
                child: isLoading
                    ? const SizedBox(
                        child: SpinKitThreeBounce(
                          size: 16,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Create Account'),
              );
            },
          ),
        ],
      ),
    );
  }
}
