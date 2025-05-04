import 'package:flutter/material.dart';

class AppTheme {
  static final lightThemeData = ThemeData().copyWith(
    colorScheme: kcolorTheme,
    textTheme: getTextTheme(Colors.black),
    primaryTextTheme: getTextTheme(Colors.white),
  );

  static final kcolorTheme = const ColorScheme.dark().copyWith(
    primary: const Color.fromARGB(255, 200, 123, 251),
    secondary: const Color.fromARGB(255, 126, 65, 186),
    tertiary: const Color.fromARGB(255, 166, 247, 230),
    surfaceBright: Colors.white,
    surface: Colors.grey.shade50,
    primaryContainer: const Color.fromARGB(255, 193, 193, 194),
    onPrimary: Colors.white,
    onSurface: const Color.fromARGB(255, 32, 32, 32),
    onTertiary: const Color.fromARGB(255, 32, 32, 32),
  );

  static TextTheme getTextTheme(Color color) {
    return TextTheme().copyWith(
      displayLarge: TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontFamily: 'tt_ramillas',
        fontSize: 32,
      ),
      displayMedium: TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontFamily: 'tt_ramillas',
        fontSize: 28,
      ),
      displaySmall: TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontFamily: 'tt_ramillas',
        fontSize: 24,
      ),
      headlineLarge: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
      headlineSmall: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      titleLarge: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: 20,
        fontFamily: 'graphic',
      ),
      bodyMedium: TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: 'graphic',
      ),
      bodySmall: TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: 12,
        fontFamily: 'graphic',
      ),
      labelLarge: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      labelMedium: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      labelSmall: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    );
  }
}
