import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcTitleContentTemplate extends StatelessWidget {
  final String title;
  final Widget content;

  const CcTitleContentTemplate({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextThemes.lightTextTheme.headlineSmall),
        const SizedBox(height: 8.0),
        content,
      ],
    );
  }
}
