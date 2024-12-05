import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/configs/show_custom_bottom_sheet.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcBuildingBottomSheetWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _nameBuildingController =
      TextEditingController();
  static final TextEditingController _numberFloorsController =
      TextEditingController();

  static void show(
    BuildContext context, {
    BuildingModel? building,
  }) {
    if (building != null) {
      _nameBuildingController.text = building.name;
      _numberFloorsController.text = building.floors!.length.toString();
    } else {
      _nameBuildingController.clear();
      _numberFloorsController.clear();
    }

    showCustomBottomSheet(
      context,
      title: building == null ? 'Registrar edificio' : 'Editar edificio',
      content: CcBuildingFormWidget(
        formKey: _formKey,
        nameBuildingController: _nameBuildingController,
        numberFloorsController: _numberFloorsController,
      ),
      actions: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CcButtonWidget(
            buttonType: ButtonType.elevated,
            onPressed: () => _onSave(context, building),
            label: building == null ? 'Registrar' : 'Actualizar',
            isLoading: false,
          ),
          const SizedBox(height: 8.0),
          CcButtonWidget(
            buttonType: ButtonType.outlined,
            onPressed: () => _onCancel(context),
            label: "Cancelar",
            isLoading: false,
          ),
        ],
      ),
    );
  }

  static void _onSave(BuildContext context, BuildingModel? building) {
    if (_formKey.currentState!.validate()) {
      final newBuilding = BuildingModel(name: _nameBuildingController.text);
      final newFloors = int.parse(_numberFloorsController.text);

      if (building == null) {
        context.read<BuildingCubit>().createBuildingWithFloors(newBuilding, newFloors);
      } else {
        context.read<BuildingCubit>().updateBuilding(
              building.copyWith(name: newBuilding.name),
              newFloors,
            );
      }
      _onCancel(context);
    }
  }

  static void _onCancel(BuildContext context) {
    _nameBuildingController.clear();
    _numberFloorsController.clear();
    Navigator.pop(context);
  }
}
