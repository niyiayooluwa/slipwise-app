import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/core/utils/validators.dart' as validators;

part 'register_form_controller.g.dart';

enum RegisterStep { email, username, password }

@immutable
class RegisterFormState {
  final RegisterStep step;
  final String email;
  final String username;
  final String password;
  final String confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirm;

  const RegisterFormState({
    this.step = RegisterStep.email,
    this.email = '',
    this.username = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscurePassword = true,
    this.obscureConfirm = true,
  });

  String? get emailError => validators.validateEmail(email);
  String? get usernameError => validators.validateUsername(username);
  String? get passwordError => validators.validatePassword(password);
  String? get confirmError =>
      confirmPassword == password && confirmPassword.isNotEmpty
      ? null
      : 'Passwords do not match';

  bool get isEmailValid => emailError == null;
  bool get isUsernameValid => usernameError == null;
  bool get isPasswordValid => passwordError == null;
  bool get isConfirmValid => confirmError == null;
  bool get isFormComplete =>
      isEmailValid && isUsernameValid && isPasswordValid && isConfirmValid;

  RegisterFormState copyWith({
    RegisterStep? step,
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirm,
  }) {
    return RegisterFormState(
      step: step ?? this.step,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirm: obscureConfirm ?? this.obscureConfirm,
    );
  }
}

@riverpod
class RegisterForm extends _$RegisterForm {
  @override
  RegisterFormState build() => const RegisterFormState();

  void setEmail(String v) => state = state.copyWith(email: v);
  void setUsername(String v) => state = state.copyWith(username: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void setConfirmPassword(String v) =>
      state = state.copyWith(confirmPassword: v);
  void togglePasswordVisible() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);
  void toggleConfirmVisible() =>
      state = state.copyWith(obscureConfirm: !state.obscureConfirm);

  void nextStep() {
    final steps = RegisterStep.values;
    final i = steps.indexOf(state.step);
    if (i < steps.length - 1) state = state.copyWith(step: steps[i + 1]);
  }

  void previousStep() {
    final steps = RegisterStep.values;
    final i = steps.indexOf(state.step);
    if (i > 0) state = state.copyWith(step: steps[i - 1]);
  }
}
