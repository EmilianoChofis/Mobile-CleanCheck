import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';

class TextThemes {
  static TextStyle _textStyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Jost',
      fontWeight: fontWeight,
      color: ColorSchemes.primary,
    );
  }

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: _textStyle(48, FontWeight.w700), // Jost-Bold
    headlineMedium: _textStyle(36, FontWeight.w700), // Jost-Bold
    headlineSmall: _textStyle(24, FontWeight.w500), // Jost-Medium
    bodyLarge: _textStyle(16, FontWeight.w400), // Jost-Regular
    bodyMedium: _textStyle(14, FontWeight.w400), // Jost-Regular
    bodySmall: _textStyle(12, FontWeight.w400), // Jost-Regular
  );
}
