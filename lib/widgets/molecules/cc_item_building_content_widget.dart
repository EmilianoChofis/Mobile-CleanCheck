import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcItemBuildingContentWidget extends StatefulWidget {
  final String room;
  const CcItemBuildingContentWidget({required this.room, super.key});

  @override
  State<CcItemBuildingContentWidget> createState() =>
      _CcItemBuildingContentWidgetState();
}

class _CcItemBuildingContentWidgetState
    extends State<CcItemBuildingContentWidget> {
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
    return Text(
      text,
      style: TextStyle(color: secondaryColor),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildDynamicText(String text) {
    return Text(
      text,
      style: TextStyle(color: primaryColor),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildRoomText(String text) {
    return Text(
      text,
      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildRow(String key, String value) {
    var isRoom = value == widget.room;
    return Row(
      children: [
        _buildStaticText(key),
        Expanded(
          child: isRoom ? _buildRoomText(value) : _buildDynamicText(value),
        ),
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
