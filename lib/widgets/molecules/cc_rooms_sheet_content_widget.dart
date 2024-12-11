import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/models/floor_model.dart';

class CcRoomsSheetContentWidget extends StatefulWidget {
  final List<FloorModel> floors;
  final Set<String> tempPinnedItems;
  final void Function(String item, bool isPinned) onToggle;

  const CcRoomsSheetContentWidget({
    required this.floors,
    required this.tempPinnedItems,
    required this.onToggle,
    super.key,
  });

  @override
  State<CcRoomsSheetContentWidget> createState() =>
      _CcRoomsSheetContentWidgetState();
}

class _CcRoomsSheetContentWidgetState extends State<CcRoomsSheetContentWidget> {
  final primaryColor = ColorSchemes.primary;
  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.floors.length,
      itemBuilder: (context, index) {
        final floor = widget.floors[index];

        if (floor.rooms!.isEmpty) {
          return Container();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                floor.name,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Rooms list for this floor
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: floor.rooms!.length,
              itemBuilder: (context, roomIndex) {
                final room = floor.rooms![roomIndex];
                final isPinned =
                    widget.tempPinnedItems.contains(room.identifier);

                return ListTile(
                  title: Text(
                    room.identifier,
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w500),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      color: secondaryColor,
                    ),
                    onPressed: () {
                      setState(() => widget.onToggle(room.identifier, isPinned));
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
