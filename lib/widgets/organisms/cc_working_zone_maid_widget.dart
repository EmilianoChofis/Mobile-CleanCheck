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
  Set<String> pinnedItems = {};

  @override
  void initState() {
    super.initState();
    _loadPinnedItems();
  }

  Future<void> _loadPinnedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final pinnedData = prefs.getString('pinnedItems');
    if (pinnedData != null) {
      setState(() => pinnedItems = Set<String>.from(json.decode(pinnedData)));
    }
  }

  Widget _buildBannerWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: CcBannerWidget(
        icon: Icons.info_outline,
        text:
            "Puedes fijar tus zonas de trabajo para tener acceso directo a ellas.",
      ),
    );
  }

  Widget _buildWorkingZonesWidget() {
    return const CcWorkingZoneItemWidget(
      icon: Icons.bed_outlined,
      title: 'Edificio Palmira',
      subtitle: '20 habitaciones',
    );
  }

  @override
  Widget build(BuildContext context) {
    return pinnedItems.isEmpty
        ? _buildBannerWidget()
        : _buildWorkingZonesWidget();
  }
}
