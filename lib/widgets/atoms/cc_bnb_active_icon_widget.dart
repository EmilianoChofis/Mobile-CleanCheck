import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';

class CcBnbActiveIconWidget extends StatelessWidget {
  final Icon icon;
  const CcBnbActiveIconWidget({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSchemes.disabled,
        borderRadius: BorderRadius.circular(64.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: icon,
    );
  }
}
