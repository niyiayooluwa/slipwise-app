import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ThemeGradients {
  static LinearGradient primaryBackground(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        colorScheme.primary.withValues(alpha: 0.55),
        colorScheme.primary.withValues(alpha: 0.35),
        colorScheme.primary.withValues(alpha: 0.25),
        colorScheme.primary.withValues(alpha: 0.15),
        colorScheme.primary.withValues(alpha: 0.08),
        colorScheme.primary.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.25, 0.45, 0.65, 0.85, 1.0],
    );
  }
}
