import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcRoomsSheetContentWidget extends StatefulWidget {
  final List<String> items;
  final Set<String> tempPinnedItems;
  final void Function(String item, bool isPinned) onToggle;

  const CcRoomsSheetContentWidget({
    required this.items,
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
      itemCount: widget.items.length * 2 - 1,
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return const Divider();
        } else {
          final itemIndex = index ~/ 2;
          final item = widget.items[itemIndex];
          final isPinned = widget.tempPinnedItems.contains(item);

          return ListTile(
            title: Text(
              item,
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            ),
            trailing: IconButton(
              icon: Icon(
                isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                color: secondaryColor,
              ),
              onPressed: () {
                setState(() {
                  widget.onToggle(item, isPinned);
                });
              },
            ),
          );
        }
      },
    );
  }
}
