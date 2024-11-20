import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isPinned = widget.tempPinnedItems.contains(item);
        return ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: Icon(
              isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              color: isPinned ? Colors.blue : null,
            ),
            onPressed: () {
              setState(() {
                widget.onToggle(item, isPinned);
              });
            },
          ),
        );
      },
    );
  }
}
