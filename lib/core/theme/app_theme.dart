import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';
import 'package:mobile_clean_check/core/theme/text_themes.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorSchemes.primary,
    textTheme: TextThemes.lightTextTheme,
    colorScheme: const ColorScheme.light(
      primary: ColorSchemes.primary,
      secondary: ColorSchemes.secondary,
      error: ColorSchemes.error,
      surface: ColorSchemes.white,
      onSurface: ColorSchemes.black,
    ),
  );
}
