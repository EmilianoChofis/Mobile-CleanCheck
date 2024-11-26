import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/configs/show_custom_bottom_sheet.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class BuildingBottomSheet {
  static void show(
      BuildContext context, {
        required GlobalKey<FormState> formKey,
        required TextEditingController nameBuildingController,
        required TextEditingController numberFloorsController,
        BuildingModel? building,
        FloorModel? floor,
        required VoidCallback onCancel,
        required Function(BuildingModel?) onSave,
      }) {
    if (building != null) {
      nameBuildingController.text = building.name;
      numberFloorsController.text = building.number.toString();
    }

    showCustomBottomSheet(
      context,
      title: building == null ? 'Registrar edificio' : 'Editar edificio',
      content: CcBuildingFormWidget(
        formKey: formKey,
        nameBuildingController: nameBuildingController,
        numberFloorsController: numberFloorsController,
      ),
      actions: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CcButtonWidget(
            buttonType: ButtonType.elevated,
            onPressed: () => onSave(building),
            label: building == null ? 'Registrar' : 'Actualizar',
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
