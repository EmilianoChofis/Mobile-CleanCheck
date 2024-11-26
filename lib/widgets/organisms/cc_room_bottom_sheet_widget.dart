import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/configs/show_custom_bottom_sheet.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcRoomBottomSheetWidget {
  static void show(
    BuildContext context, {
    required GlobalKey<FormState> formKey,
    required TextEditingController buildingController,
    required TextEditingController floorController,
    required TextEditingController numberRoomsController,
    required BuildingModel building,
    RoomModel? room,
    required VoidCallback onCancel,
    required Function(RoomModel?) onSave,
  }) {
    if (room != null) {
      buildingController.text = room.floor.building.name;
      floorController.text = room.floor.name;
      numberRoomsController.text = room.identifier;
    }

    showCustomBottomSheet(
      context,
      title: room == null ? 'Registrar habitación' : 'Editar habitación',
      content: CcRoomFormWidget(
        formKey: formKey,
        buildingController: buildingController,
        floorController: floorController,
        numberRoomsController: numberRoomsController,
      ),
      actions: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CcButtonWidget(
            buttonType: ButtonType.elevated,
            onPressed: () => onSave(room),
            label: room == null ? 'Registrar' : 'Actualizar',
            isLoading: false,
          ),
          const SizedBox(height: 8.0),
          CcButtonWidget(
            buttonType: ButtonType.outlined,
            onPressed: onCancel,
            label: "Cancelar",
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
