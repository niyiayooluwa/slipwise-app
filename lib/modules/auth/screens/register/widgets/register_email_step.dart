import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/screens/register/controller/register_form_controller.dart';

class RegisterEmailStep extends StatelessWidget {
  final RegisterForm notifier;
  final RegisterFormState form;
  final bool isAnyLoading;
  final TextEditingController emailController;

  const RegisterEmailStep({
    super.key,
    required this.notifier,
    required this.form,
    required this.isAnyLoading,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      child: Column(
        children: [
          ShadInputFormField(
            controller: emailController,
            placeholder: const Text("you@example.com"),
            leading: const Icon(LucideIcons.mail, size: 16),
            keyboardType: TextInputType.emailAddress,
            onChanged: notifier.setEmail,
            validator: (_) => form.emailError,
          ),

          const Spacer(),

          ShadButton(
            width: double.infinity,
            size: ShadButtonSize.lg,
            enabled: !isAnyLoading && form.isEmailValid,
            onPressed: !isAnyLoading && form.isEmailValid
                ? () => notifier.nextStep()
                : null,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
