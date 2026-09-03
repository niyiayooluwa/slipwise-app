import 'package:flutter/material.dart';

extension SemanticColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Semantic Status Colors
  Color get statusWon =>
      isDark ? const Color(0xff4ade80) : const Color(0xff22c55e);

  Color get statusLost =>
      isDark ? const Color(0xfff87171) : const Color(0xffef4444);

  Color get statusPending =>
      isDark ? const Color(0xfffbbf24) : const Color(0xfff59e0b);
}
