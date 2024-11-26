import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcRoomIcon extends StatelessWidget {
  final RoomType roomType;

  const CcRoomIcon({
    required this.roomType,
    super.key,
  });

  final secondaryColor = ColorSchemes.secondary;
  final whiteColor = ColorSchemes.white;
  final grayColor = ColorSchemes.disabled;
  final redColor = ColorSchemes.error;
  final yellowColor = ColorSchemes.warning;

  Color _getBackgroundColor() {
    switch (roomType) {
      case RoomType.occupied:
        return grayColor;
      case RoomType.unoccupied:
        return grayColor;
      case RoomType.clean:
        return whiteColor;
      case RoomType.checked:
        return redColor;
      case RoomType.in_maintenance:
        return yellowColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64),
        color: _getBackgroundColor(),
      ),
      child: Icon(
        Icons.bed_outlined,
        color: roomType == RoomType.in_maintenance ? grayColor : secondaryColor,
      ),
    );
  }
}

enum RoomType {
  occupied,
  unoccupied,
  clean,
  checked,
  in_maintenance,
}