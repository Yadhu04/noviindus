import 'package:flutter/material.dart';
import 'package:noviindus/core/theme/app_colours.dart';
import 'package:noviindus/core/theme/app_text_style.dart';

class AppTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.backgroundPrimary,

    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.buttonPrimary,
      surface: AppColors.backgroundSecondary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),

    textTheme: TextTheme(
      bodyLarge: AppTextStyle.body,
      bodyMedium: AppTextStyle.bodySecondary,
      titleLarge: AppTextStyle.title,
    ),

    dividerColor: AppColors.backgroundSecondary,
  );
}
