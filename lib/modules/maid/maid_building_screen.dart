import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class MaidBuildingScreen extends StatefulWidget {
  const MaidBuildingScreen({super.key});

  @override
  State<MaidBuildingScreen> createState() => _MaidBuildingScreenState();
}

class _MaidBuildingScreenState extends State<MaidBuildingScreen> {
  final ValueNotifier<String?> selectedRoomNotifier =
      ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(
        title: 'Registrar limpieza',
        actions: [CcPinButtonWidget()],
      ),
      body: CcBuildingRoomsTemplate(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder<String?>(
            valueListenable: selectedRoomNotifier,
            builder: (context, selectedRoom, _) {
              return CcItemListWidget(
                iconType: IconType.enabled,
                title: 'Edificio Palmira',
                content: CcItemBuildingContentWidget(
                  room: selectedRoom ?? '...',
                ),
                icon: Icons.apartment,
                onTap: () {},
              );
            },
          ),
        ),
        title: 'Habitaciones',
        filters: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CcFiltersWidget(
              filters: const [
                'Zona de trabajo',
                'Todas',
                'Sin limpiar',
                'Limpias',
                'Reportadas',
                'Deshabilitadas',
              ],
              onSelected: (filter) {},
            ),
            const CcSymbologyWidget(
              grayLabel: 'Limpia',
              whiteLabel: 'Sin limpiar',
              yellowLabel: 'Reportada',
              redLabel: 'Deshabilitada',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [CcFloorWidget(selectedRoomNotifier: selectedRoomNotifier)],
        ),
        actions: ValueListenableBuilder<String?>(
          valueListenable: selectedRoomNotifier,
          builder: (context, selectedRoom, _) {
            if (selectedRoom != null) {
              return Row(
                children: [
                  CcReportButtonWidget(
                    selectedRoomNotifier: selectedRoomNotifier,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: CcCleanButtonWidget(
                      selectedRoomNotifier: selectedRoomNotifier,
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
