import 'package:flutter/material.dart';

class CcRoomNameWidget extends StatelessWidget {
  final String name;
  final Color colorText;
  final bool isSelected;

  const CcRoomNameWidget({
    required this.name,
    required this.colorText,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        color: colorText,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }
}