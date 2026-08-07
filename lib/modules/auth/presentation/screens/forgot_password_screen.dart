import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/presentation/hooks/forgot_password_hook.dart';
import 'package:slipwise/modules/auth/providers/notifier/forgot_password_notifier.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final form = useForgotPasswordForm();
    final authState = ref.watch(forgotPasswordProvider);
    final isLoading = authState.isLoading;

    ref.listen(forgotPasswordProvider, (previous, next) {
      if (next is AsyncError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Error'),
            description: Text(next.error.toString()),
          ),
        );
      } else if (next is AsyncData &&
          !next.isLoading &&
          previous?.isLoading == true) {
        ShadToaster.of(context).show(
          const ShadToast(
            title: Text('OTP Sent'),
            description: Text('Check your email for the reset code.'),
          ),
        );
        context.push(
          '/reset-password',
          extra: form.emailController.text.trim(),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _top(context),
              const SizedBox(height: 32),
              _forgotPasswordForm(context, ref, isLoading, form),
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
        Text(
          'Forgot Password',
          style: theme.textTheme.h2.copyWith(height: 1.2),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email address to receive a password reset code.',
          style: theme.textTheme.muted.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _forgotPasswordForm(
    BuildContext context,
    WidgetRef ref,
    bool isLoading,
    ForgotPasswordFormState form,
  ) {
    return ShadForm(
      key: form.formKey,
      child: Column(
        children: [
          ShadInputFormField(
            id: 'email',
            //label: const Text('Email Address'),
            placeholder: const Text('name@example.com'),
            controller: form.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v.isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
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
                              .read(forgotPasswordProvider.notifier)
                              .forgotPassword(form.emailController.text.trim());
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
                    : const Text('Send Reset Code'),
              );
            },
          ),
        ],
      ),
    );
  }
}
