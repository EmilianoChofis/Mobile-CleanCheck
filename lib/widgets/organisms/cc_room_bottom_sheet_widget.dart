import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/configs/show_custom_bottom_sheet.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcRoomBottomSheetWidget {
  static void show(
    BuildContext context, {
    required GlobalKey<FormState> formKey,
    bool quickAccess = false,
    required TextEditingController buildingsController,
    required TextEditingController floorsController,
    required TextEditingController numberRoomsController,
    RoomModel? room,
    required VoidCallback onCancel,
    required Function(RoomModel?) onSave,
  }) {
    if (room != null) {
      floorsController.text = room.floor.name;
      numberRoomsController.text = room.identifier;
    }

    showCustomBottomSheet(
      context,
      title: room == null ? 'Registrar habitación' : 'Editar habitación',
      content: CcRoomFormWidget(
        formKey: formKey,
        quickAccess: quickAccess,
        buildingsController: buildingsController,
        floorsController: floorsController,
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
