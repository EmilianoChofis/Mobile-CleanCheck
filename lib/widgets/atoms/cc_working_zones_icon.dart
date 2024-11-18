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

  Color _getIconColor() {
    switch (iconType) {
      case IconType.disabled:
        return ColorSchemes.error;
      case IconType.reported:
        return ColorSchemes.warning;
      case IconType.enabled:
        return ColorSchemes.disabled;
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
        color: ColorSchemes.secondary,
      ),
    );
  }
}

enum IconType {
  disabled,
  reported,
  enabled,
}