import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class MaidBuildingScreen extends StatefulWidget {
  const MaidBuildingScreen({super.key});

  @override
  State<MaidBuildingScreen> createState() => _MaidBuildingScreenState();
}

class _MaidBuildingScreenState extends State<MaidBuildingScreen> {
  final ValueNotifier<String?> selectedRoomNotifier =
      ValueNotifier<String?>(null);

  final redColor = ColorSchemes.error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(
        title: "Registrar limpieza",
        actions: [CcPinButtonWidget()],
      ),
      body: CcBuildingRoomsTemplate(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder<String?>(
            valueListenable: selectedRoomNotifier,
            builder: (context, selectedRoom, _) {
              return CcItemListWidget(
                title: "Edificio Palmira",
                subtitle: CcItemListBuildingContentWidget(
                  room: selectedRoom ?? '...',
                ),
                icon: Icons.apartment,
                onTap: () {},
              );
            },
          ),
        ),
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
          children: [
            CcFloorWidget(selectedRoomNotifier: selectedRoomNotifier),
          ],
        ),
        actions: Row(
          children: [
            CcButtonWidget(
              buttonType: ButtonType.outlined,
              prefixIcon: const Icon(Icons.warning_amber),
              label: 'Reportar',
              isLoading: false,
              color: redColor,
              onPressed: () {},
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CcButtonWidget(
                buttonType: ButtonType.elevated,
                label: 'Marcar como limpia',
                isLoading: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
