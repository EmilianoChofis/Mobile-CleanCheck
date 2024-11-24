import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcFabBuildingWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const CcFabBuildingWidget({required this.onPressed, super.key});

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
      child: const Icon(Icons.add),
    );
  }
}
