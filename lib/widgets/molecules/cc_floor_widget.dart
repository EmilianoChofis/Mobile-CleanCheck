import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcFloorWidget extends StatelessWidget {
  final ValueNotifier<String?> selectedRoomNotifier;

  const CcFloorWidget({required this.selectedRoomNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    const String floor = 'Piso 1';
    final rooms = [
      {'name': 'P1H1', 'state': RoomStatus.reported},
      {'name': 'P1H2', 'state': RoomStatus.empty},
      {'name': 'P1H3', 'state': RoomStatus.empty},
      {'name': 'P1H4', 'state': RoomStatus.reported},
      {'name': 'P1H5', 'state': RoomStatus.cleaned},
      {'name': 'P1H6', 'state': RoomStatus.disabled},
      {'name': 'P1H7', 'state': RoomStatus.empty},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CcFloorTitleWidget(floor: floor),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: rooms.map((room) {
              final roomName = room['name'].toString();
              final roomState = room['state'] as RoomStatus;

              return GestureDetector(
                onTap: roomState == RoomStatus.empty
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
          const CcDividerWidget(),
        ],
      ),
    );
  }
}
