import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcLogoWidget extends StatelessWidget {
  final surfaceColor = ColorSchemes.white;

  const CcLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      color: surfaceColor,
    );
  }
}
