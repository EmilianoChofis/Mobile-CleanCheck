import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class CcRoomsWrapTemplate extends StatelessWidget {
  final List<RoomModel> rooms;
  final Future<void> Function() onRefresh;
  final ValueNotifier<Map<String, String>?> selectedRoomNotifier;

  const CcRoomsWrapTemplate({
    required this.rooms,
    required this.onRefresh,
    required this.selectedRoomNotifier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, List<RoomModel>> floorsWithRooms = {};

    for (var room in rooms) {
      if (room.floor != null) {
        if (!floorsWithRooms.containsKey(room.floor!.name)) {
          floorsWithRooms[room.floor!.name] = [];
        }
        floorsWithRooms[room.floor!.name]!.add(room);
      }
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: rooms.isEmpty
          ? const CcLoadedErrorWidget(
        title: 'No hay pisos con habitaciones registradas',
      )
          : Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: CustomScrollView(
          slivers: [
            for (var floorName in floorsWithRooms.keys) ...[
              SliverStickyHeader(
                header: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    floorName,
                    style: const TextStyle(
                      color: ColorSchemes.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final floorRooms = floorsWithRooms[floorName]!;

                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: floorRooms
                            .map((room) {
                          final roomId = room.identifier;
                          final roomName = room.name;
                          final roomState = RoomStatus.values.firstWhere(
                                (e) =>
                            e.toString() == 'RoomStatus.${room.status?.toLowerCase()}',
                            orElse: () => RoomStatus.unoccupied,
                          );

                          return GestureDetector(
                            onTap: () => selectedRoomNotifier.value = {
                              'identifier': room.identifier,
                              'id': room.id!,
                            },
                            child: ValueListenableBuilder<Map<String, String>?>(
                              valueListenable: selectedRoomNotifier,
                              builder: (context, selectedRoom, _) {
                                return CcRoomWidget(
                                  name: roomName,
                                  state: roomState,
                                  isSelected: selectedRoom != null &&
                                      selectedRoom['identifier'] == roomId,
                                );
                              },
                            ),
                          );
                        }).toList(),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
