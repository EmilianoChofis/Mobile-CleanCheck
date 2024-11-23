import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

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
    dividerTheme: const DividerThemeData(
      color: ColorSchemes.disabled,
      space: 0,
      thickness: 1,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: ColorSchemes.secondary,
      suffixIconColor: ColorSchemes.secondary,
      hintStyle: TextStyle(
        //custom font
        fontFamily: 'Jost',
        fontWeight: FontWeight.w400,
        color: ColorSchemes.secondary,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorSchemes.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorSchemes.primary,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorSchemes.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorSchemes.error,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(ColorSchemes.primary),
        foregroundColor: WidgetStateProperty.all<Color>(ColorSchemes.white),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all<Color>(ColorSchemes.primary.withOpacity(0.1)),
        foregroundColor: WidgetStateProperty.all<Color>(ColorSchemes.primary),
        side: WidgetStateProperty.all<BorderSide>(const BorderSide(color: ColorSchemes.primary)),
      ),
    ),
  );
}
