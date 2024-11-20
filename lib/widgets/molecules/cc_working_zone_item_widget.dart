import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcWorkingZoneItemWidget extends StatelessWidget {
  final IconData icon;
  final String building;
  final String rooms;
  final VoidCallback? onTap;

  const CcWorkingZoneItemWidget({
    required this.icon,
    required this.building,
    required this.rooms,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            CcWorkingZonesIcon(
              icon: icon,
              iconType: IconType.enabled,
            ),
            Text(
              building,
              style: const TextStyle(
                color: ColorSchemes.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              rooms,
              style: const TextStyle(
                color: ColorSchemes.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
