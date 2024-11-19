import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcItemListWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget subtitle;
  final VoidCallback onTap;

  const CcItemListWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final primaryColor = ColorSchemes.primary;
  final black = ColorSchemes.black;
  final white = ColorSchemes.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.16),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          child: ListTile(
            leading: CcWorkingZonesIcon(icon: icon, iconType: IconType.enabled),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
            subtitle: subtitle,
          ),
        ),
      ),
    );
  }
}
