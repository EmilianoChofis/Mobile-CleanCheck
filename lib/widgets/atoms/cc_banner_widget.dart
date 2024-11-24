import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcBannerWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final IconData? trailing;
  final GestureTapCallback? onTap;

  const CcBannerWidget({
    required this.text,
    this.icon,
    this.trailing,
    this.onTap,
    super.key,
  });

  final primaryColor = ColorSchemes.primary;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          onTap: onTap,
          leading: icon != null ? Icon(icon, color: primaryColor) : null,
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconColor: primaryColor,
          textColor: primaryColor,
          dense: true,
          trailing: trailing != null ? Icon(trailing) : null,
        ),
      ),
    );
  }
}
