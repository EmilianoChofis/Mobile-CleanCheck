import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcWorkingZoneTemplate extends StatelessWidget {
  final String title;
  final Widget actions;

  const CcWorkingZoneTemplate({
    required this.title,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ColorSchemes.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        actions,
      ],
    );
  }
}
