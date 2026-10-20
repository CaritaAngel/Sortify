import 'package:flutter/material.dart';

class AppColors {
  static const green = Color(0xFF176B4D);
  static const greenDark = Color(0xFF10553C);
  static const greenLight = Color(0xFFE8F4EC);
  static const mint = Color(0xFFF1F7F1);
  static const background = Color(0xFFF7F8F5);
  static const text = Color(0xFF24352D);
  static const muted = Color(0xFF78847D);
  static const border = Color(0xFFE4EAE4);
  static const amber = Color(0xFFFFF0D2);
  static const blue = Color(0xFFE5F1F6);
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.light,
      primary: AppColors.green,
      surface: Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: AppColors.text, height: 1.2),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text),
        titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text),
        bodyLarge: TextStyle(fontSize: 14, color: AppColors.text, height: 1.4),
        bodyMedium: TextStyle(fontSize: 13, color: AppColors.text, height: 1.4),
        bodySmall: TextStyle(fontSize: 11, color: AppColors.muted, height: 1.35),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.text),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: AppColors.border)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.green, width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.redAccent)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, minimumSize: const Size(44, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), textStyle: const TextStyle(fontWeight: FontWeight.w700)),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: const BorderSide(color: AppColors.border)),
        selectedColor: AppColors.greenLight,
        backgroundColor: Colors.white,
        labelStyle: const TextStyle(fontSize: 12, color: AppColors.text),
        side: const BorderSide(color: AppColors.border),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.greenLight,
        height: 68,
        labelTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
