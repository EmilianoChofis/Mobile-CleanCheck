import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcPinButtonWidget extends StatefulWidget {
  final BuildingModel building;

  const CcPinButtonWidget({
    required this.building,
    super.key,
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
    final userId = prefs.getString('userId');
    const String key = 'pinnedItems';
    final String? savedData = prefs.getString('${key}_$userId');
    if (savedData != null) {
      final Map<String, dynamic> decodedData = jsonDecode(savedData);
      final List<dynamic> rooms = decodedData[widget.building.name] ?? [];
      setState(() {
        pinnedItems = Set<String>.from(rooms.map((room) => jsonEncode(room)));
        tempPinnedItems =
            Set<String>.from(rooms.map((room) => jsonEncode(room)));
      });
    }
  }


  Future<Map<String, dynamic>> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    const String key = 'pinnedItems';

    final String? savedData = prefs.getString(key);
    if (savedData != null) {
      return Map<String, dynamic>.from(jsonDecode(savedData));
    } else {
      return {};
    }
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
                floors: widget.building.floors!,
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

  void _onSave() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final existingData = await _loadDataFromPrefs();

    final existingRooms = existingData[widget.building.name] ?? [];

    final newRooms = tempPinnedItems.map((item) {
      final room = widget.building.floors!
          .expand((floor) => floor.rooms!)
          .firstWhere((r) => r.identifier == item);
      return {
        'buildingName': widget.building.name,
        'id': room.id,
        'identifier': room.identifier,
        'name': room.name,
      };
    }).toList();

    final combinedRooms = <dynamic>{
      ...existingRooms,
      ...newRooms,
    }.toList(); // Evitar duplicados

    // Actualizar pinnedItems localmente
    setState(() {
      pinnedItems = Set<String>.from(combinedRooms.map((room) => jsonEncode(room)));
    });

    // Guardar en SharedPreferences
    existingData[widget.building.name] = combinedRooms;
    final jsonData = jsonEncode(existingData);
    await prefs.setString('pinnedItems_$userId', jsonData);

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
