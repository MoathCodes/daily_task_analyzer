import 'package:flutter/material.dart';

class AppPalette {
  static const Color primary = Color(0xFF9C6BFF);
  static const Color primaryVariant = Color(0xFF6D4CFF);
  static const Color secondary = Color(0xFF4ECDC4);
  static const Color accent = Color(0xFFFF8E53);
  static const Color background = Color(0xFF05060A);
  static const Color surface = Color(0xFF0F1424);
  static const Color surfaceHigh = Color(0xFF1A2035);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textMuted = Color(0xFF94A3B8);

  static const LinearGradient pageGradient = LinearGradient(
    colors: [Color(0xFF05060A), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x66121A2C), Color(0x3327344E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient highlightGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxShadow glow(Color color) => BoxShadow(
    color: color.withOpacity(0.25),
    blurRadius: 20,
    spreadRadius: 1,
    offset: const Offset(0, 10),
  );

  const AppPalette._();
}
