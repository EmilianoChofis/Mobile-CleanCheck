import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcWorkingZoneManagerWidget extends StatefulWidget {
  const CcWorkingZoneManagerWidget({super.key});

  @override
  State<CcWorkingZoneManagerWidget> createState() =>
      _CcWorkingZoneManagerWidgetState();
}

class _CcWorkingZoneManagerWidgetState
    extends State<CcWorkingZoneManagerWidget> {
  static List<Map<String, dynamic>> items = [
    {
      'icon': Icons.apartment_outlined,
      'title': 'Registrar edificio',
      'onTap': () => print('Registrar edificio'),
    },
    {
      'icon': Icons.bed_outlined,
      'title': 'Registrar habitación',
      'onTap': () => print('Registrar habitación'),
    },
    {
      'icon': Icons.person_outline,
      'title': 'Registrar usuario',
      'onTap': () => print('Registrar usuario'),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map(
        (item) {
          return CcWorkingZoneItemWidget(
            icon: item['icon'],
            title: item['title'],
            onTap: item['onTap'],
          );
        },
      ).toList(),
    );
  }
}
