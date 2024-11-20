import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcPinButtonWidget extends StatefulWidget {
  const CcPinButtonWidget({super.key});

  @override
  State<CcPinButtonWidget> createState() => _CcPinButtonWidgetState();
}

class _CcPinButtonWidgetState extends State<CcPinButtonWidget> {
  void _showBottomSheet(BuildContext context) {
    List<String> items = [
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 4",
      "Item 5",
      "Item 6",
      "Item 7",
      "Item 8",
      "Item 9",
      "Item 10",
      "Item 11",
      "Item 12",
    ];
    Set<String> pinnedItems = {};
    Set<String> tempPinnedItems = Set<String>.from(pinnedItems);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      enableDrag: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return CcBottomSheetTemplate(
              title: "Fijar zona de trabajo",
              subtitle:
                  "Puedes establecer las habitaciones de este edificio como zona de trabajo para tener acceso directo.",
              content: CcRoomsSheetContentWidget(
                items: items,
                tempPinnedItems: tempPinnedItems,
                onToggle: (item, isPinned) {
                  setModalState(() {
                    if (isPinned) {
                      tempPinnedItems.remove(item);
                    } else {
                      tempPinnedItems.add(item);
                    }
                  });
                },
              ),
              onCancel: () => Navigator.pop(context),
              onSave: () {
                setState(() => pinnedItems = Set<String>.from(tempPinnedItems));
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showBottomSheet(context),
      icon: const Icon(Icons.push_pin_outlined),
    );
  }
}
