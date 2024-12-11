import 'package:flutter/material.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcWorkingZoneManagerWidget extends StatelessWidget {
  const CcWorkingZoneManagerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.apartment_outlined,
        'title': 'Registrar edificio',
        'onTap': () => _showBuildingBottomSheet(context),
      },
      {
        'icon': Icons.bed_outlined,
        'title': 'Registrar habitación',
        'onTap': () => _showRoomBottomSheet(context),
      },
      {
        'icon': Icons.person_outline,
        'title': 'Registrar usuario',
        'onTap': () => _showUserBottomSheet(context),
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

  void _showBuildingBottomSheet(BuildContext context,
      {BuildingModel? building}) {
    CcBuildingBottomSheetWidget.show(context, building: building);
  }

  void _showRoomBottomSheet(BuildContext context) {
    CcRoomBottomSheetWidget.show(context, quickAccess: true);
  }

  void _showUserBottomSheet(BuildContext context) {
    CcUserBottomSheetWidget.show(context);
  }
}
