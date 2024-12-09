import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcFabWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CcFabWidget({required this.onPressed, required this.icon, super.key});

  final primaryColor = ColorSchemes.primary;
  final secondaryColor = ColorSchemes.secondary;
  final grayColor = ColorSchemes.disabled;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      backgroundColor: grayColor,
      foregroundColor: secondaryColor,
      child: Icon(icon),
    );
  }
}
