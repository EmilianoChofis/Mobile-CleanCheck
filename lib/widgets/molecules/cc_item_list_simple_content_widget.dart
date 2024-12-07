import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcItemListSimpleContentWidget extends StatelessWidget {
  final String subtitle;
  const CcItemListSimpleContentWidget({required this.subtitle, super.key});

  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    return Text(subtitle, style: TextStyle(color: secondaryColor));
  }
}
