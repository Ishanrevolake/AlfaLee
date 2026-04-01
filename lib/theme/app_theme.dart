import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color primary = Color(0xFFDC143C); // Red accent
  static const Color textBody = Colors.black87;
  static const Color textDim = Colors.black54;

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(fontWeight: FontWeight.w400, letterSpacing: -0.5),
          displayMedium: const TextStyle(fontWeight: FontWeight.w400, letterSpacing: -0.5),
          displaySmall: const TextStyle(fontWeight: FontWeight.w400),
          headlineMedium: const TextStyle(fontWeight: FontWeight.w400),
          titleLarge: const TextStyle(fontWeight: FontWeight.w400),
          bodyLarge: const TextStyle(fontWeight: FontWeight.w300),
          bodyMedium: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ).apply(
        bodyColor: textBody,
        displayColor: textBody,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textDim,
        type: BottomNavigationBarType.fixed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Colors.black, // Dark text on light app bar
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
