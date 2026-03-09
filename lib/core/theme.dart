import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';

class LightTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF7F7F9),
    fontFamily: 'LexendDeca',
    colorScheme: ColorScheme.fromSeed(seedColor: Appcolors.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF5F33E1),
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: AppTextStyles.titleLarge,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
    ),
  );
}
