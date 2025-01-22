import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';

class AppThemes {
  static ThemeData themeData = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.background,
      onPrimary: AppColors.primaryText,
      secondary: AppColors.accent,
      onSecondary: AppColors.background,
      error: Colors.red,
      onError: Colors.white,
      surface: AppColors.backgroundAlt,
      onSurface: AppColors.primaryText,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.background,
    ),
  );
}
