import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CcWorkingZoneMaidWidget extends StatefulWidget {
  const CcWorkingZoneMaidWidget({super.key});

  @override
  State<CcWorkingZoneMaidWidget> createState() =>
      _CcWorkingZoneMaidWidgetState();
}

class _CcWorkingZoneMaidWidgetState extends State<CcWorkingZoneMaidWidget> {
  Map<String, List<Map<String, dynamic>>> pinnedItems = {};

  @override
  void initState() {
    super.initState();
    _loadPinnedItems();
  }

  Future<void> _loadPinnedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final pinnedData = prefs.getString('pinnedItems_$userId');
    if (pinnedData != null) {
      final Map<String, dynamic> decodedData = json.decode(pinnedData);
      setState(() {
        pinnedItems = Map<String, List<Map<String, dynamic>>>.from(
          decodedData.map((key, value) {
            return MapEntry(key, List<Map<String, dynamic>>.from(value));
          }),
        );
      });
    }
  }

  Widget _buildWorkingZonesWidget() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pinnedItems.length,
        itemBuilder: (context, index) {
          final buildingName = pinnedItems.keys.elementAt(index);
          final rooms = pinnedItems[buildingName] ?? [];

          return Row(
            children: [
              CcWorkingZoneItemWidget(
                icon: Icons.bed_outlined,
                title: buildingName,
                subtitle: '${rooms.length} habitaciones',
              ),
              const SizedBox(width: 8),
            ],
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return pinnedItems.isEmpty
        ? const CcBannerWidget(
            icon: Icons.info_outline,
            text:
                "Puedes fijar tus zonas de trabajo para tener acceso directo a ellas.",
          )
        : _buildWorkingZonesWidget();
  }
}
