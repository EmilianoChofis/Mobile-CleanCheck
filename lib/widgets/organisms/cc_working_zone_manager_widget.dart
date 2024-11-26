import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcWorkingZoneManagerWidget extends StatelessWidget {
  final VoidCallback onRegisterBuilding;

  const CcWorkingZoneManagerWidget({
    required this.onRegisterBuilding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.apartment_outlined,
        'title': 'Registrar edificio',
        'onTap': onRegisterBuilding,
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map(
            (item) {
          return CcWorkingZoneItemWidget(
            icon: item['icon'] as IconData,
            title: item['title'] as String,
            onTap: item['onTap'] as VoidCallback,
          );
        },
      ).toList(),
    );
  }
}
