import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/providers/register_form_controller.dart';
import 'package:slipwise/modules/auth/providers/register_controller.dart';
import 'package:slipwise/modules/auth/providers/google_auth_notifier.dart';
import 'package:slipwise/modules/auth/screens/shared/auth_error_listener.dart';
import 'package:slipwise/core/providers/user_notifier.dart';
import 'package:slipwise/modules/auth/screens/register/widgets/register_email_step.dart';
import 'package:slipwise/modules/auth/screens/register/widgets/register_username_step.dart';
import 'package:slipwise/modules/auth/screens/register/widgets/register_password_step.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Theme
    final theme = ShadTheme.of(context);

    // Screen State
    final authState = ref.watch(registerControllerProvider);
    final isGoogleLoading = ref.watch(googleAuthProvider).isLoading;

    // Derived specific states
    final isLoading = authState.isLoading;
    final isAnyLoading = isLoading || isGoogleLoading;

    // TextField Controllers
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    // Form State
    final form = ref.watch(registerFormProvider);
    // Form Notifier
    final notifier = ref.read(registerFormProvider.notifier);

    // Google Auth listener to show error or navigate to home
    return AuthErrorListener<void>(
      provider: googleAuthProvider,
      errorTitle: 'Google Sign-In Failed',
      onSuccess: (context, state) {
        final user = ref.read(userProvider).value;
        if (user != null) {
          if (user.username == null || user.username!.isEmpty) {
            context.go('/set-username');
          } else {
            context.go('/home');
          }
        }
      },
      child: AuthErrorListener<void>(
        provider: registerControllerProvider,
        errorTitle: 'Registration Failed',
        onSuccess: (context, state) {
          context.push('/verify-otp', extra: form.email);
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
                  // Top section with the title and description based on the current
                  // step of the registration process.
                  _top(context, form, notifier),
                  const SizedBox(height: 24),

                  // Expanded widget to take up the remaining space for the form display.
                  Expanded(
                    child: _displayForm(
                      context,
                      form,
                      isAnyLoading,
                      ref,
                      notifier,
                      emailController,
                      usernameController,
                      passwordController,
                      confirmPasswordController,
                    ),
                  ),

                  // Bottom section with the "Continue with Google" button and other
                  // information based on the current step of the registration process.
                  _bottom(context, ref, isAnyLoading, form),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Top section to display the headers of each step of the registration process.
  // It shows a logo or back arrow based on the current step, and displays a
  // big text title and small text description.
  Widget _top(
    BuildContext context,
    RegisterFormState form,
    RegisterForm notifier,
  ) {
    final theme = ShadTheme.of(context);

    // Big text title based on the current step of the registration process.
    final bigText = switch (form.step) {
      RegisterStep.email => "What’s your email address?",
      RegisterStep.password => "Create a secure password",
      RegisterStep.username => "Pick a username",
    };

    // Small text description based on the current step of the registration process.
    final smallText = switch (form.step) {
      RegisterStep.email => "We’ll send you a code to verify it.",
      RegisterStep.password => "Make sure it’s at least 8 characters long.",
      RegisterStep.username => "This is how others will see you.",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Show the logo if on the email step, otherwise show a back arrow to go
        // to the previous step.
        if (form.step == RegisterStep.email) ...[
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              'assets/drawables/logo/white.svg',
              height: 40,
              width: 40,
              semanticsLabel: 'Splash Screen Logo',
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.light
                    ? theme.colorScheme.primary
                    : theme.colorScheme.foreground,
                BlendMode.srcIn,
              ),
            ),
          ),
        ] else ...[
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              child: const Icon(LucideIcons.arrowLeft, size: 24),
              onTap: () {
                notifier.previousStep();
              },
            ),
          ),
        ],
        const SizedBox(height: 24),

        // Display the big text title and small text description.
        Text(bigText, style: theme.textTheme.h2.copyWith(height: 1.2)),
        const SizedBox(height: 16),
        Text(
          smallText,
          style: theme.textTheme.muted.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  // Bottom section with the "Continue with Google" button and other information
  // based on the current step of the registration process.
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
        if (form.step == RegisterStep.email) ...[const SizedBox(height: 24)],

        // If the current step is the email step, show the
        // "Continue with Google" button and some information about email
        // privacy.
        if (form.step == RegisterStep.email) ...[
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

          // Google Sign-In button with loading state and error handling.
          ShadButton.outline(
            decoration: ShadDecoration(
              border: ShadBorder.all(color: theme.colorScheme.primary),
            ),
            foregroundColor: Colors.white,
            size: ShadButtonSize.lg,
            onPressed: isGoogleLoading
                ? null
                : () async {
                    await ref.read(googleAuthProvider.notifier).signIn();
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

        // If the current step is the password step, show the Terms of Service
        // and Privacy Policy links.
        if (form.step == RegisterStep.password) ...[
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

        // if the current step is the email step, show the
        // "Already have an account? Sign in here" link.
        if (form.step == RegisterStep.email) ...[
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

  // Display the appropriate form based on the current step of the registration
  // process.
  Widget _displayForm(
    BuildContext context,
    RegisterFormState form,
    bool isAnyLoading,
    WidgetRef ref,
    RegisterForm notifier,
    TextEditingController emailController,
    TextEditingController usernameController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) {
    switch (form.step) {
      case RegisterStep.email:
        return RegisterEmailStep(
          notifier: notifier,
          form: form,
          isAnyLoading: isAnyLoading,
          emailController: emailController,
        );
      case RegisterStep.password:
        return RegisterPasswordStep(
          notifier: notifier,
          form: form,
          isAnyLoading: isAnyLoading,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        );
      case RegisterStep.username:
        return RegisterUsernameStep(
          notifier: notifier,
          form: form,
          usernameController: usernameController,
        );
    }
  }
}
