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

  static const Map<RoomStatus, Color> _stateColors = {
    RoomStatus.empty: ColorSchemes.white,
    RoomStatus.cleaned: ColorSchemes.disabled,
    RoomStatus.reported: ColorSchemes.warning,
    RoomStatus.disabled: ColorSchemes.error,
  };

  Color borderColor() {
    if (state == RoomStatus.reported || state == RoomStatus.disabled) {
      return _stateColors[state]!;
    }
    return isSelected ? ColorSchemes.primary : ColorSchemes.disabled;
  }

  Color textColor() {
    return state == RoomStatus.disabled
        ? ColorSchemes.white
        : ColorSchemes.primary;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _stateColors[state] ?? ColorSchemes.white;

    return Container(
      width: 82,
      height: 82,
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
}

enum RoomStatus {
  empty,
  cleaned,
  reported,
  disabled,
}
