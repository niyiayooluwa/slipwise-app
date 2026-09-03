import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/validators.dart';
import 'package:slipwise/core/errors/failures.dart';
import 'package:slipwise/modules/auth/providers/login_form_controller.dart';
import 'package:slipwise/modules/auth/providers/login_controller.dart';
import 'package:slipwise/modules/auth/screens/shared/auth_error_listener.dart';
import 'package:slipwise/modules/auth/providers/google_auth_notifier.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final form = useLoginForm();

    final vm = ref.watch(loginControllerProvider);
    final isLoading = vm.isLoading;
    final isGoogleLoading = ref.watch(googleAuthProvider).isLoading;
    final isAnyLoading = isLoading || isGoogleLoading;

    return AuthErrorListener<void>(
      provider: googleAuthProvider,
      errorTitle: 'Google Sign-In Failed',
      onSuccess: (context, state) {
        context.go('/home');
      },
      child: AuthErrorListener<void>(
        provider: loginControllerProvider,
        errorTitle: 'Login Failed',
        onSuccess: (context, state) {
          context.go('/home');
        },
        onError: (context, error) {
          if (error.toString() == const EmailNotVerifiedFailure().message) {
            context.push(
              '/verify-otp',
              extra: form.emailController.text.trim(),
            );
            return true;
          }
          return false;
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
                  _top(context),
                  const SizedBox(height: 24),
                  _loginForm(context, ref, isAnyLoading, form),
                  const SizedBox(height: 24),
                  Expanded(child: _bottom(context, ref, isAnyLoading)),
                ],
              ),
            ),
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

        Text('Welcome back', style: theme.textTheme.h2.copyWith(height: 0.7)),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue',
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
      // FIX: Changed .stretch to CrossAxisAlignment.stretch
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
          decoration: ShadDecoration(
            border: ShadBorder.all(color: theme.colorScheme.primary),
          ),
          foregroundColor: theme.colorScheme.foreground,
          size: ShadButtonSize.lg,
          onPressed: isGoogleLoading
              ? null
              : () {
                  ref.read(googleAuthProvider.notifier).signIn();
                },
          leading: isGoogleLoading
              ? null
              : SvgPicture.asset(
                  "assets/drawables/google.svg",
                  height: 18,
                  width: 18,
                ),
          child: isGoogleLoading
              ? SizedBox(
                  child: SpinKitThreeBounce(size: 16, color: theme.colorScheme.foreground),
                )
              : const Text("Continue with Google"),
        ),

        const Spacer(),

        Text.rich(
          TextSpan(
            text: "New to SlipWise? ",
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            children: [
              TextSpan(
                text: 'Create account',
                style: TextStyle(color: theme.colorScheme.primary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.replace('/register');
                  },
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _loginForm(
    BuildContext context,
    WidgetRef ref,
    bool isLoading,
    LoginFormState form,
  ) {
    final dTheme = Theme.of(context);
    final theme = ShadTheme.of(context);

    return ShadForm(
      key: form.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Please type in a password';
                  }
                  return null;
                },

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

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.push('/forgot-password');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot Password?',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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
                              .read(loginControllerProvider.notifier)
                              .signInWithEmail(
                                email: form.emailController.text.trim(),
                                password: form.passwordController.text,
                              );
                        }
                      },
                width: double.infinity,
                size: ShadButtonSize.lg,
                child: isLoading
                    ? SizedBox(
                        child: SpinKitThreeBounce(
                          size: 16,
                          color: theme.colorScheme.primaryForeground,
                        ),
                      )
                    : const Text('Sign In'),
              );
            },
          ),
        ],
      ),
    );
  }
}
