import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcTitleScreenWidget extends StatelessWidget {
  final String title;
  const CcTitleScreenWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return
      Text(title, style: TextThemes.lightTextTheme.headlineSmall);
  }
}
