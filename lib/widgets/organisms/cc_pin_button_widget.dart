import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcPinButtonWidget extends StatefulWidget {
  final List<String> roomIdentifiers;
  final String buildingIdentifier;

  const CcPinButtonWidget({
    super.key,
    required this.roomIdentifiers,
    required this.buildingIdentifier,
  });

  @override
  State<CcPinButtonWidget> createState() => _CcPinButtonWidgetState();
}

class _CcPinButtonWidgetState extends State<CcPinButtonWidget> {
  Set<String> pinnedItems = {};
  Set<String> tempPinnedItems = {};

  @override
  void initState() {
    super.initState();
    _loadPinnedItems();
  }

  Future<void> _loadPinnedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String key = 'pinnedItems_${widget.buildingIdentifier}';

    final List<String>? savedItems = prefs.getStringList(key);
    if (savedItems != null) {
      setState(() {
        pinnedItems = Set<String>.from(savedItems);
        tempPinnedItems = Set<String>.from(savedItems);
      });
    }
    print('Pinned Items for ${widget.buildingIdentifier}: $pinnedItems');
  }

  Future<void> _savePinnedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String key = 'pinnedItems_${widget.buildingIdentifier}';

    await prefs.setStringList(key, pinnedItems.toList());
    print('Pinned Items saved for ${widget.buildingIdentifier}: $pinnedItems');
  }

  void _showBottomSheet(BuildContext context) {
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
                items: widget.roomIdentifiers,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
    setState(() {
      pinnedItems = Set<String>.from(tempPinnedItems);
    });
    _savePinnedItems();
    Navigator.pop(context);
  }

  void _onCancel() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showBottomSheet(context),
      icon: const Icon(Icons.push_pin_outlined),
    );
  }
}
