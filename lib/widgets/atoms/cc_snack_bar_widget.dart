import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';

class CcSnackBarWidget {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType snackBarType,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: snackBarType == SnackBarType.warning
              ? ColorSchemes.primary
              : ColorSchemes.disabled,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: _getSnackBarColor(snackBarType),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getSnackBarColor(SnackBarType snackBarType) {
    switch (snackBarType) {
      case SnackBarType.error:
        return ColorSchemes.error;
      case SnackBarType.success:
        return ColorSchemes.success;
      case SnackBarType.warning:
        return ColorSchemes.warning;
    }
  }
}

enum SnackBarType { error, success, warning }
