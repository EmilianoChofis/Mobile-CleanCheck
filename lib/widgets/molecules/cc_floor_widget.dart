import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class CcFloorWidget extends StatelessWidget {
  final ValueNotifier<String?> selectedRoomNotifier;
  final FloorModel floor;

  const CcFloorWidget({
    required this.selectedRoomNotifier,
    required this.floor,
    super.key,
  });

  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    if (floor.rooms == null || floor.rooms!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            floor.name,
            style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: floor.rooms!.map((room) {
              final roomName = room.name;
              final roomState = RoomStatus.values.firstWhere(
                    (e) => e.toString() == 'RoomStatus.${room.status?.toLowerCase()}',
                orElse: () => RoomStatus.checked,
              );

              return GestureDetector(
                onTap: roomState == RoomStatus.checked
                    ? () => selectedRoomNotifier.value = roomName
                    : null,
                child: ValueListenableBuilder<String?>(
                  valueListenable: selectedRoomNotifier,
                  builder: (context, selectedRoom, _) {
                    return CcRoomWidget(
                      name: roomName,
                      state: roomState,
                      isSelected: selectedRoom == roomName,
                    );
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24.0),
          const Divider(),
        ],
      ),
    );
  }
}
