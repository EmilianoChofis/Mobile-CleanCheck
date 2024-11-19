import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcItemListBuildingContentWidget extends StatefulWidget {
  final String room;
  const CcItemListBuildingContentWidget({required this.room, super.key});

  @override
  State<CcItemListBuildingContentWidget> createState() =>
      _CcItemListBuildingContentWidgetState();
}

class _CcItemListBuildingContentWidgetState
    extends State<CcItemListBuildingContentWidget> {
  final primaryColor = ColorSchemes.primary;
  final secondaryColor = ColorSchemes.secondary;
  String? userName;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    _getUserName();
    _setFormattedDate();
  }

  Future<void> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => userName = prefs.getString('user'));
  }

  void _setFormattedDate() {
    final now = DateTime.now();
    formattedDate = DateFormat('dd/MM/yyyy').format(now);
  }

  Widget _buildStaticText(String text) {
    return Text(text, style: TextStyle(color: secondaryColor));
  }

  Widget _buildDynamicText(String text) {
    return Text(text, style: TextStyle(color: primaryColor));
  }

  Widget _buildRoomText(String text) {
    return Text(
      text,
      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildRow(String key, String value) {
    var isRoom = value == widget.room;
    return Row(
      children: [
        _buildStaticText(key),
        isRoom ? _buildRoomText(value) : _buildDynamicText(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRow('Usuario: ', userName ?? 'Usuario'),
        _buildRow('Fecha: ', formattedDate),
        _buildRow('Habitación: ', widget.room),
      ],
    );
  }
}
