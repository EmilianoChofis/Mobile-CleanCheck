import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcFloorTitleWidget extends StatelessWidget {
  final String floor;
  const CcFloorTitleWidget({required this.floor, super.key});

  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    return Text(
      floor,
      style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
    );
  }
}
