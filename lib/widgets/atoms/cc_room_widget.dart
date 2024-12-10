import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcRoomWidget extends StatelessWidget {
  final String name;
  final RoomStatus state;
  final bool isSelected;

  const CcRoomWidget({
    required this.name,
    required this.state,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _stateColors[state] ?? ColorSchemes.white;

    return Container(
      width: 88,
      height: 88,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor(),
          width: isSelected ? 1.5 : 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: CcRoomNameWidget(
          name: name,
          colorText: textColor(),
          isSelected: isSelected,
        ),
      ),
    );
  }

  static const Map<RoomStatus, Color> _stateColors = {
    RoomStatus.checked: ColorSchemes.white,
    RoomStatus.occupied: ColorSchemes.disabled,
    RoomStatus.unoccupied: ColorSchemes.secondary,
    RoomStatus.clean: ColorSchemes.success,
    RoomStatus.in_maintenance: ColorSchemes.warning,
  };

  Color borderColor() {
    if (state == RoomStatus.in_maintenance) {
      return _stateColors[state]!;
    }
    return isSelected ? ColorSchemes.primary : ColorSchemes.disabled;
  }

  Color textColor() {
    return state == RoomStatus.clean || state == RoomStatus.unoccupied
        ? ColorSchemes.white
        : ColorSchemes.primary;
  }
}

enum RoomStatus {
  checked,
  occupied,
  unoccupied,
  clean,
  in_maintenance,
}
