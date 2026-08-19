import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/validators.dart' as validators;
import 'package:slipwise/modules/auth/presentation/hooks/register_form_hook.dart';
import 'package:slipwise/modules/auth/providers/notifier/register_notifier.dart';
import 'package:slipwise/modules/auth/providers/notifier/google_auth_notifier.dart';
import 'package:slipwise/modules/auth/providers/notifier/user_notifier.dart';
import 'package:slipwise/modules/onboarding/providers/utility_notifier.dart';

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

    // Listeners remain the same
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
              _top(context, form),
              const SizedBox(height: 24),
              Expanded(child: _displayForm(context, form, isAnyLoading, ref)),

              _bottom(context, ref, isAnyLoading, form),
            ],
          ),
        ),
      ),
    );
  }

  Widget _top(BuildContext context, RegisterFormState form) {
    final theme = ShadTheme.of(context);

    final bigText = switch (form.currentStep.value) {
      RegisterStep.email => "What’s your email address?",
      RegisterStep.password => "Create a secure password",
      RegisterStep.username => "Pick a username",
    };

    final smallText = switch (form.currentStep.value) {
      RegisterStep.email => "We’ll send you a code to verify it.",
      RegisterStep.password => "Make sure it’s at least 8 characters long.",
      RegisterStep.username => "This is how others will see you.",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //const SizedBox(height: 24),
        if (form.currentStep.value == RegisterStep.email) ...[
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              'assets/drawables/logo/white.svg',
              height: 40,
              width: 40,
              semanticsLabel: 'Splash Screen Logo',
            ),
          ),
        ] else ...[
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              child: const Icon(LucideIcons.arrowLeft, size: 24),
              onTap: () {
                form.previousStep();
              },
            ),
          ),
        ],
        const SizedBox(height: 24),
        Text(bigText, style: theme.textTheme.h2.copyWith(height: 1.2)),
        const SizedBox(height: 8),
        Text(
          smallText,
          style: theme.textTheme.muted.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _bottom(
    BuildContext context,
    WidgetRef ref,
    bool isAnyLoading,
    RegisterFormState form,
  ) {
    final theme = ShadTheme.of(context);
    final isGoogleLoading = ref.watch(googleAuthProvider).isLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (form.currentStep.value == RegisterStep.email) ...[
          const SizedBox(height: 24),
        ],
        if (form.currentStep.value == RegisterStep.email) ...[
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
            foregroundColor: Colors.white,
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
                ? const SizedBox(
                    child: SpinKitThreeBounce(size: 16, color: Colors.white),
                  )
                : const Text("Continue with Google"),
          ),
          const SizedBox(height: 24),

          Text(
            " We'll use your email for account verification and important updates. "
            "Your email is private and won't be shared by default.",
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            //textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
        ],

        if (form.currentStep.value == RegisterStep.password) ...[
          SizedBox(height: 24),

          Text.rich(
            TextSpan(
              text: 'By creating an account, you agree to our ',
              style: theme.textTheme.muted.copyWith(
                color: theme.colorScheme.mutedForeground,
              ),
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to Terms of Service
                      context.push('/terms');
                    },
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to Privacy Policy
                      context.push('/privacy');
                    },
                ),
                TextSpan(text: '.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],

        if (form.currentStep.value == RegisterStep.email) ...[
          Text.rich(
            TextSpan(
              text: "Already have an account? ",
              style: theme.textTheme.muted.copyWith(
                color: theme.colorScheme.mutedForeground,
              ),
              children: [
                TextSpan(
                  text: 'Sign in here',
                  style: TextStyle(color: theme.colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.replace('/login');
                    },
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _displayForm(
    BuildContext context,
    RegisterFormState form,
    bool isAnyLoading,
    WidgetRef ref,
  ) {
    switch (form.currentStep.value) {
      case RegisterStep.email:
        return _emailStep(context, form, isAnyLoading);
      case RegisterStep.password:
        return _passwordStep(context, form, isAnyLoading, ref);
      case RegisterStep.username:
        return _usernameStep(context, form);
    }
  }

  Widget _emailStep(
    BuildContext context,
    RegisterFormState form,
    bool isAnyLoading,
  ) {
    return ShadForm(
      child: Column(
        children: [
          ShadInputFormField(
            controller: form.emailController,
            placeholder: Text("you@example.com"),
            leading: const Icon(LucideIcons.mail, size: 16),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => validators.validateEmail(value),
          ),

          Spacer(),

          ValueListenableBuilder(
            valueListenable: form.isEmailValid,
            builder: (context, isValid, _) {
              return ShadButton(
                width: double.infinity,
                size: ShadButtonSize.lg,
                enabled: isValid && !isAnyLoading,
                onPressed: isValid && !isAnyLoading
                    ? () {
                        form.nextStep();
                      }
                    : null,
                child: const Text('Next'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _usernameStep(BuildContext context, RegisterFormState form) {
    return ShadForm(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShadInputFormField(
            controller: form.usernameController,
            placeholder: Text("username"),
            leading: const Icon(LucideIcons.atSign, size: 16),
            keyboardType: TextInputType.twitter,
            validator: (value) => validators.validateUsername(value),
          ),

          // Show username availability status
          Consumer(
            builder: (context, ref, child) {
              final utilityState = ref.watch(utilityProvider);

              return utilityState.when(
                data: (_) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Username is available ✓',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                loading: () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Checking availability...',
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                error: (error, stack) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          error.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const Spacer(),

          // Continue button with Consumer
          Consumer(
            builder: (context, ref, child) {
              final utilityState = ref.watch(utilityProvider);

              // Check if username is available and valid
              final isAvailable = utilityState.when(
                data: (_) => true,
                loading: () => false,
                error: (_, _) => false,
              );

              final isValid = form.isUsernameValid.value;

              return ShadButton(
                onPressed: isAvailable && isValid
                    ? () async {
                        await ref
                            .read(utilityProvider.notifier)
                            .checkUsername(form.usernameController.text.trim());
                        form.nextStep();
                      }
                    : null,
                child: const Text('Continue'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _passwordStep(
    BuildContext context,
    RegisterFormState form,
    bool isAnyLoading,
    WidgetRef ref,
  ) {
    return ShadForm(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder(
            valueListenable: form.isPasswordVisible,
            builder: (context, isVisible, _) {
              return ShadInputFormField(
                controller: form.passwordController,
                placeholder: Text("Enter your password"),
                obscureText: !isVisible,
                leading: Icon(LucideIcons.lock, size: 16),
                validator: (value) => validators.validatePassword(value),
                trailing: InkWell(
                  child: Icon(isVisible ? LucideIcons.eye : LucideIcons.eyeOff),
                  onTap: () {
                    form.isPasswordVisible.value = !isVisible;
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: form.passwordController,
            builder: (context, _) {
              return _passwordRequirements(
                context,
                form.passwordController.text,
              );
            },
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder(
            valueListenable: form.isConfirmPasswordVisible,
            builder: (context, isVisible, _) {
              return ShadInputFormField(
                controller: form.confirmPasswordController,
                placeholder: Text("Confirm your password"),
                obscureText: !isVisible,
                leading: Icon(LucideIcons.lock, size: 16),
                validator: (value) => form.validateConfirmPassword(value),
                trailing: InkWell(
                  child: Icon(isVisible ? LucideIcons.eye : LucideIcons.eyeOff),
                  onTap: () {
                    form.isConfirmPasswordVisible.value = !isVisible;
                  },
                ),
              );
            },
          ),

          const Spacer(),

          const Spacer(),

          ValueListenableBuilder(
            valueListenable: form.isFormValid,
            builder: (context, isValid, _) {
              return ShadButton(
                onPressed: !isAnyLoading && isValid
                    ? () {
                        if (kDebugMode) log("Clicked");
                        ref
                            .read(registerProvider.notifier)
                            .signUp(
                              email: form.emailController.text.trim(),
                              password: form.passwordController.text,
                              username: form.usernameController.text.trim(),
                            );
                      }
                    : null,
                child: const Text('Next'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _passwordRequirements(BuildContext context, String password) {
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
                color: met ? Colors.green : theme.colorScheme.mutedForeground,
              ),
              const SizedBox(width: 8),
              Text(
                entry.key,
                style: theme.textTheme.small.copyWith(
                  color: met ? Colors.green : theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
