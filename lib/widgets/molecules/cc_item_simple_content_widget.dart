import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcItemSimpleContentWidget extends StatelessWidget {
  final String subtitle;
  const CcItemSimpleContentWidget({required this.subtitle, super.key});

  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    return Text(subtitle, style: TextStyle(color: secondaryColor));
  }
}
