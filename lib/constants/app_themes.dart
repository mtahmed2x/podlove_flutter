import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData themeData = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFEFEFE),
      onPrimary: Color(0xFF333333),
      secondary: Color(0xFFFFA175),
      onSecondary: Color(0xFFFEFEFE),
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFFF8F8F8),
      onSurface: Color(0xFF333333),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Color(0xFFFEFEFE),
    ),
  );
}
