import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcWorkingZonesIcon extends StatelessWidget {
  final IconData icon;
  final IconType iconType;

  const CcWorkingZonesIcon({
    required this.icon,
    required this.iconType,
    super.key,
  });

  final secondaryColor = ColorSchemes.secondary;
  final grayColor = ColorSchemes.disabled;
  final redColor = ColorSchemes.error;
  final yellowColor = ColorSchemes.warning;

  Color _getIconColor() {
    switch (iconType) {
      case IconType.enabled:
        return grayColor;
      case IconType.reported:
        return yellowColor;
      case IconType.disabled:
        return redColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64),
        color: _getIconColor(),
      ),
      child: Icon(
        icon,
        color: iconType == IconType.disabled ? grayColor : secondaryColor,
      ),
    );
  }
}

enum IconType {
  enabled,
  reported,
  disabled,
}
