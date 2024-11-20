import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcDividerWidget extends StatelessWidget {
  const CcDividerWidget({super.key});

  final grayColor = ColorSchemes.disabled;

  @override
  Widget build(BuildContext context) {
    return Divider(color: grayColor);
  }
}
