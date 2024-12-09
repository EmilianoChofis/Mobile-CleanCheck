import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcWorkingZoneReceptionistWidget extends StatefulWidget {
  final VoidCallback onViewRooms;
  final VoidCallback onRegisterCheckIn;
  final VoidCallback onRegisterCheckOut;

  const CcWorkingZoneReceptionistWidget({
    required this.onViewRooms,
    required this.onRegisterCheckIn,
    required this.onRegisterCheckOut,
    super.key,
  });

  @override
  State<CcWorkingZoneReceptionistWidget> createState() =>
      _CcWorkingZoneReceptionistWidgetState();
}

class _CcWorkingZoneReceptionistWidgetState
    extends State<CcWorkingZoneReceptionistWidget> {
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.bed_outlined,
        'title': 'Ver habitaciones',
        'onTap': widget.onViewRooms,
      },
      {
        'icon': Icons.room_service_outlined,
        'title': 'Registrar entrada',
        'onTap': widget.onRegisterCheckIn,
      },
      {
        'icon': Icons.luggage_outlined,
        'title': 'Registrar salida',
        'onTap': widget.onRegisterCheckOut,
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
