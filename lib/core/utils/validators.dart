// core/utils/validators.dart

/// Returns an error message if the password is invalid, null if valid.
/// Rules: 8+ chars, uppercase, lowercase, digit, special character.
String? validatePassword(String password) {
  if (password.length < 8) return 'Password must be at least 8 characters';
  if (!password.contains(RegExp(r'[A-Z]'))) return 'Password must contain an uppercase letter';
  if (!password.contains(RegExp(r'[a-z]'))) return 'Password must contain a lowercase letter';
  if (!password.contains(RegExp(r'[0-9]'))) return 'Password must contain a number';
  if (!password.contains(RegExp(r'[@\$!%*?&]'))) return 'Password must contain a special character (@\$!%*?&)';
  return null;
}

/// Returns an error message if the email is invalid, null if valid.
String? validateEmail(String email) {
  final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$');
  if (email.isEmpty) return 'Email is required';
  if (!emailRegex.hasMatch(email)) return 'Enter a valid email address';
  return null;
}