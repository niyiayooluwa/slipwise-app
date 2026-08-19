import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/utils/validators.dart' as validators;

// Only 3 steps
enum RegisterStep { email, username, password }

class RegisterFormState {
  // Controllers
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  // Visibility
  final ValueNotifier<bool> isPasswordVisible;
  final ValueNotifier<bool> isConfirmPasswordVisible;

  // Step Management
  final ValueNotifier<RegisterStep> currentStep;
  final GlobalKey<ShadFormState> formKey;

  // Per-step validation flags
  final ValueNotifier<bool> isUsernameValid;
  final ValueNotifier<bool> isEmailValid;
  final ValueNotifier<bool> isPasswordValid;
  final ValueNotifier<bool> isConfirmValid;
  final ValueNotifier<bool> isFormValid;
  final String? Function(String) validateConfirmPassword;

  RegisterFormState({
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.currentStep,
    required this.formKey,
    required this.isUsernameValid,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isConfirmValid,
    required this.validateConfirmPassword,
    required this.isFormValid,
  });

  bool get isFormComplete =>
      isUsernameValid.value &&
      isEmailValid.value &&
      isPasswordValid.value &&
      isConfirmValid.value;

  // Check if current step is valid
  bool isCurrentStepValid() {
    switch (currentStep.value) {
      case RegisterStep.email:
        return isEmailValid.value;
      case RegisterStep.username:
        return isUsernameValid.value;
      case RegisterStep.password:
        return isPasswordValid.value && isConfirmValid.value;
    }
  }

  void previousStep() {
    final steps = RegisterStep.values;
    final currentIndex = steps.indexOf(currentStep.value);
    if (currentIndex > 0) {
      currentStep.value = steps[currentIndex - 1];
    }
  }

  void nextStep() {
    final steps = RegisterStep.values;
    final currentIndex = steps.indexOf(currentStep.value);
    if (currentIndex < steps.length - 1) {
      currentStep.value = steps[currentIndex + 1];
    }
  }

  void goToStep(RegisterStep step) {
    currentStep.value = step;
  }
}

RegisterFormState useRegisterForm() {
  final usernameController = useTextEditingController();
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();
  final confirmPasswordController = useTextEditingController();

  final isPasswordVisible = useState(false);
  final isConfirmPasswordVisible = useState(false);
  final currentStep = useState(RegisterStep.email); // Start with email
  final formKey = useMemoized(() => GlobalKey<ShadFormState>());

  // Per-step validation states
  final isUsernameValid = useState(false);
  final isEmailValid = useState(false);
  final isPasswordValid = useState(false);
  final isConfirmValid = useState(false);
  final isFormValid = useState(false);

  // Validation functions
  void recomputeFormValid() {
    isFormValid.value =
        isUsernameValid.value &&
        isEmailValid.value &&
        isPasswordValid.value &&
        isConfirmValid.value;
  }

  String? validateUsername(String value) {
    final error = validators.validateUsername(value);
    isUsernameValid.value = error == null;
    recomputeFormValid();
    return error;
  }

  String? validateEmail(String value) {
    final error = validators.validateEmail(value);
    isEmailValid.value = error == null;
    recomputeFormValid();
    return error;
  }

  String? validatePassword(String value) {
    final error = validators.validatePassword(value);
    isPasswordValid.value = error == null;
    recomputeFormValid();
    return error;
  }

  String? validateConfirmPassword(String value) {
    final isValid = value == passwordController.text && value.isNotEmpty;
    isConfirmValid.value = isValid;
    recomputeFormValid();
    return isValid ? null : 'Passwords do not match';
  }

  // Update confirm validation when password changes
  useEffect(() {
    void updateConfirm() {
      if (confirmPasswordController.text.isNotEmpty) {
        validateConfirmPassword(confirmPasswordController.text);
      }
    }

    passwordController.addListener(updateConfirm);
    return () => passwordController.removeListener(updateConfirm);
  }, [passwordController, confirmPasswordController]);

  // inside useRegisterForm(), after the existing validate* closures are defined

  useEffect(() {
    void updateEmail() => validateEmail(emailController.text);
    emailController.addListener(updateEmail);
    return () => emailController.removeListener(updateEmail);
  }, [emailController]);

  useEffect(() {
    void updateUsername() => validateUsername(usernameController.text);
    usernameController.addListener(updateUsername);
    return () => usernameController.removeListener(updateUsername);
  }, [usernameController]);

  useEffect(() {
    void updatePassword() => validatePassword(passwordController.text);
    passwordController.addListener(updatePassword);
    return () => passwordController.removeListener(updatePassword);
  }, [passwordController]);

  // Re-validate confirm when entering password step
  useEffect(() {
    if (currentStep.value == RegisterStep.password) {
      validateConfirmPassword(confirmPasswordController.text);
    }
    return null;
  }, [currentStep.value]);

  return RegisterFormState(
    usernameController: usernameController,
    emailController: emailController,
    passwordController: passwordController,
    confirmPasswordController: confirmPasswordController,
    isPasswordVisible: isPasswordVisible,
    isConfirmPasswordVisible: isConfirmPasswordVisible,
    currentStep: currentStep,
    formKey: formKey,
    isUsernameValid: isUsernameValid,
    isEmailValid: isEmailValid,
    isPasswordValid: isPasswordValid,
    isConfirmValid: isConfirmValid,
    isFormValid: isFormValid, // <-- was missing
    validateConfirmPassword: validateConfirmPassword,
  );
}
