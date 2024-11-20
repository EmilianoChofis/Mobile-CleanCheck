import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcBannerWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconData? trailing;

  const CcBannerWidget({
    required this.icon,
    required this.text,
    this.trailing,
    super.key,
  });

  final primaryColor = ColorSchemes.primary;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text, style: const TextStyle(fontSize: 16.0)),
        iconColor: primaryColor,
        textColor: primaryColor,
        dense: true,
        trailing: trailing != null ? Icon(trailing) : null,
      ),
    );
  }
}
