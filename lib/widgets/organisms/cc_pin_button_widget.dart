import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcPinButtonWidget extends StatefulWidget {
  const CcPinButtonWidget({super.key});

  @override
  State<CcPinButtonWidget> createState() => _CcPinButtonWidgetState();
}

class _CcPinButtonWidgetState extends State<CcPinButtonWidget> {
  Set<String> pinnedItems = {};
  Set<String> tempPinnedItems = {};

  void _showBottomSheet(BuildContext context) {
    List<String> items = [
      'P1H1',
      'P1H2',
      'P1H3',
      'P1H4',
      'P1H5',
      'P1H6',
      'P1H7',
      'P1H8',
      'P1H9',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
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
              actions: Column(
                children: [
                  CcButtonWidget(
                    buttonType: ButtonType.elevated,
                    onPressed: _onSave,
                    label: "Fijar habitaciones",
                    isLoading: false,
                  ),
                  const SizedBox(height: 8.0),
                  CcButtonWidget(
                    buttonType: ButtonType.outlined,
                    onPressed: _onCancel,
                    label: "Cancelar",
                    isLoading: false,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onSave() {
    setState(() => pinnedItems = Set<String>.from(tempPinnedItems));
    Navigator.pop(context);
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showBottomSheet(context),
      icon: const Icon(Icons.push_pin_outlined),
    );
  }
}
