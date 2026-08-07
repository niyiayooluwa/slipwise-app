import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResetPasswordFormState {
  final TextEditingController otpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueNotifier<bool> isPasswordVisible;
  final ValueNotifier<bool> isConfirmPasswordVisible;
  final ValueNotifier<bool> isStep1Valid;
  final ValueNotifier<bool> isStep2Valid;
  final GlobalKey<ShadFormState> formKey;
  final PageController pageController;

  ResetPasswordFormState({
    required this.otpController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.isStep1Valid,
    required this.isStep2Valid,
    required this.formKey,
    required this.pageController,
  });
}

ResetPasswordFormState useResetPasswordForm() {
  final otpController = useTextEditingController();
  final passwordController = useTextEditingController();
  final confirmPasswordController = useTextEditingController();
  
  final isPasswordVisible = useState(false);
  final isConfirmPasswordVisible = useState(false);
  
  final isStep1Valid = useState(false);
  final isStep2Valid = useState(false);
  
  final formKey = useMemoized(() => GlobalKey<ShadFormState>());
  final pageController = usePageController();

  useEffect(() {
    void updateFormValidity() {
      // Step 1: OTP must be 6 digits
      isStep1Valid.value = otpController.text.trim().length == 6;

      // Step 2: Password must be valid and match confirm password
      final pw = passwordController.text;
      final cpw = confirmPasswordController.text;
      isStep2Valid.value = pw.isNotEmpty && pw.length >= 8 && pw == cpw;
    }

    otpController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
    confirmPasswordController.addListener(updateFormValidity);

    return () {
      otpController.removeListener(updateFormValidity);
      passwordController.removeListener(updateFormValidity);
      confirmPasswordController.removeListener(updateFormValidity);
    };
  }, [otpController, passwordController, confirmPasswordController]);

  return ResetPasswordFormState(
    otpController: otpController,
    passwordController: passwordController,
    confirmPasswordController: confirmPasswordController,
    isPasswordVisible: isPasswordVisible,
    isConfirmPasswordVisible: isConfirmPasswordVisible,
    isStep1Valid: isStep1Valid,
    isStep2Valid: isStep2Valid,
    formKey: formKey,
    pageController: pageController,
  );
}
