import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundDark = Color(0xFF121212);
  static const Color backgroundLight = Color(0xFF2A2A2A);
  static const Color neonYellow = Color(0xFFFFEF00);
  static const Color neonGreen = Color(0xFF00FF00);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0BEC5);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundDark, backgroundLight],
  );
}