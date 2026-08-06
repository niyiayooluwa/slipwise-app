import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/validators.dart';
import 'package:slipwise/modules/auth/presentation/hooks/login_form_hook.dart';
import 'package:slipwise/modules/auth/providers/notifier/login_notifier.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    final vm = ref.watch(loginProvider);
    final isLoading = vm.isLoading;

    ref.listen(loginProvider, (previous, next) {
      if (next is AsyncError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Login Failed'),
            description: Text(next.error.toString()),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _top(context),
              const SizedBox(height: 24),
              _loginForm(context, ref, isLoading),
              const SizedBox(height: 24),
              Expanded(child: _bottom(context, isLoading)),
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

  Widget _bottom(BuildContext context, bool isLoading) {
    final theme = ShadTheme.of(context);
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
          width: double.infinity,
          leading: SvgPicture.asset(
            "assets/drawables/google.svg",
            height: 18,
            width: 18,
          ),
          onPressed: isLoading
              ? null
              : () {
                  // ref.read(loginProvider.notifier).signInWithGoogle();
                  ShadToaster.of(context).show(
                    const ShadToast(
                      title: Text('Coming Soon'),
                      description: Text(
                        'Google Sign-In is not fully implemented yet.',
                      ),
                    ),
                  );
                },
          child: const Text('Continue with Google'),
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
                    context.push('/register');
                  },
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context, WidgetRef ref, bool isLoading) {
    final dTheme = Theme.of(context);
    final theme = ShadTheme.of(context);
    final form = useLoginForm();

    return ShadForm(
      key: form.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShadInputFormField(
            id: 'email',
            controller: form.emailController,
            label: Text('EMAIL', style: dTheme.textTheme.labelMedium),
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
                label: Text('PASSWORD', style: dTheme.textTheme.labelMedium),
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
                ShadToaster.of(context).show(
                  const ShadToast(
                    title: Text('Forgot Password'),
                    description: Text('Password reset flow coming soon.'),
                  ),
                );
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
                    : () async {
                        if (form.formKey.currentState!.saveAndValidate()) {
                          await ref
                              .read(loginProvider.notifier)
                              .signInWithEmail(
                                email: form.emailController.text.trim(),
                                password: form.passwordController.text,
                              );

                          if (context.mounted) {
                            final state = ref.read(loginProvider);
                            if (!state.hasError) {
                              context.go('/home');
                            }
                          }
                        }
                      },
                width: double.infinity,
                child: isLoading
                    ? SizedBox(
                        child: SpinKitThreeBounce(
                          size: 16,
                          color: Colors.white,
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
