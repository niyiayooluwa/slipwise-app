import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/providers/verify_otp_form_controller.dart';
import 'package:slipwise/modules/auth/providers/verify_otp_controller.dart';
import 'package:slipwise/modules/auth/screens/shared/auth_error_listener.dart';

class VerifyOtpScreen extends HookConsumerWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final form = useVerifyOtpForm();
    final authState = ref.watch(verifyOtpControllerProvider);
    final isLoading = authState.isLoading;

    // Auto-resend OTP once on initial load
    useEffect(() {
      Future.microtask(() {
        ref.read(verifyOtpControllerProvider.notifier).resendOtp(email);
        if (context.mounted) {
          ShadToaster.of(context).show(
            const ShadToast(
              title: Text('OTP Sent'),
              description: Text('A fresh code has been sent to your email.'),
            ),
          );
        }
      });
      return null;
    }, []);

    return AuthErrorListener<void>(
      provider: verifyOtpControllerProvider,
      errorTitle: 'Verification Failed',
      onSuccess: (context, state) {
        context.go('/home');
      },
      child: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _top(context),
                const SizedBox(height: 32),
                _verifyForm(context, ref, isLoading, form),
                const SizedBox(height: 48),
                _bottom(context, ref),
              ],
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
        const SizedBox(height: 24),
        Text(
          'Verify your email',
          style: theme.textTheme.h2.copyWith(height: 0.7),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a 6-digit code to $email',
          style: theme.textTheme.muted.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _bottom(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    return Text.rich(
      TextSpan(
        text: "Didn't receive the code? ",
        style: theme.textTheme.muted.copyWith(
          color: theme.colorScheme.mutedForeground,
        ),
        children: [
          TextSpan(
            text: 'Resend',
            style: TextStyle(color: theme.colorScheme.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                ref.read(verifyOtpControllerProvider.notifier).resendOtp(email);
                ShadToaster.of(context).show(
                  const ShadToast(
                    title: Text('OTP Sent'),
                    description: Text(
                      'A fresh code has been sent to your email.',
                    ),
                  ),
                );
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _verifyForm(
    BuildContext context,
    WidgetRef ref,
    bool isLoading,
    VerifyOtpFormState form,
  ) {
    return ShadForm(
      key: form.formKey,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
              if (v.contains(' ')) {
                return 'Fill the whole OTP code';
              }
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
            valueListenable: form.isFormValid,
            builder: (context, isValid, _) {
              return ShadButton(
                size: ShadButtonSize.lg,
                enabled: isValid && !isLoading,
                onPressed: isLoading || !isValid
                    ? null
                    : () {
                        if (form.formKey.currentState!.saveAndValidate()) {
                          ref
                              .read(verifyOtpControllerProvider.notifier)
                              .verifyOtp(
                                email: email,
                                code: form.otpController.text.trim(),
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
                    : const Text('Verify Account'),
              );
            },
          ),
        ],
      ),
    );
  }
}
