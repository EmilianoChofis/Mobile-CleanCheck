import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/configs/show_custom_bottom_sheet.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/services/services.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcRoomBottomSheetWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _roomsController = TextEditingController();
  static final TextEditingController _buildingsController =
      TextEditingController();
  static final TextEditingController _floorsController =
      TextEditingController();

  static void show(
    BuildContext context, {
    bool quickAccess = false,
    BuildingModel? building,
    RoomModel? room,
  }) {
    if (room != null) {
      _buildingsController.text = room.floor!.buildingId!;
      _floorsController.text = room.floor!.name;
      _roomsController.text = room.identifier;
    }

    showCustomBottomSheet(
      context,
      title: room == null ? 'Registrar habitación' : 'Editar habitación',
      content: CcRoomFormWidget(
        formKey: _formKey,
        quickAccess: quickAccess,
        buildingsController: _buildingsController,
        floorsController: _floorsController,
        roomsController: _roomsController,
      ),
      actions: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CcButtonWidget(
            buttonType: ButtonType.elevated,
            onPressed: () => _onSave(context, building, room),
            label: room == null ? 'Registrar' : 'Actualizar',
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

  static void _onSave(
      BuildContext context, BuildingModel? building, RoomModel? room) async {
    if (_formKey.currentState!.validate()) {
      final roomCubit = context.read<RoomCubit>();
      final buildingCubit = context.read<BuildingCubit>();
      final roomService = RoomService();

      late FloorModel floor;

      final navigator = Navigator.of(context);

      if (building == null) {
        final buildingId = _buildingsController.text;
        final rb = await buildingCubit.getBuildingById(buildingId);

        if (rb == null) {
          return;
        }

        floor = rb.floors!.firstWhere(
          (floor) => floor.id == _floorsController.text,
          orElse: () => throw Exception('Floor not found'),
        );
      } else {
        floor = building.floors!.firstWhere(
          (floor) => floor.id == _floorsController.text,
          orElse: () => throw Exception('Floor not found'),
        );
      }

      final rooms = await roomService.generateRooms(
        floorId: _floorsController.text,
        newRooms: int.parse(_roomsController.text),
        lastRoomNumber: floor.rooms!.length,
        floorControllerText: _floorsController.text,
        roomsControllerText: _roomsController.text,
      );

      await roomCubit.createListRooms(rooms);
      await buildingCubit.getBuildings();

      navigator.pop();
      _buildingsController.clear();
      _floorsController.clear();
      _roomsController.clear();
    }
  }

  static void _onCancel(BuildContext context) {
    Navigator.pop(context);
    _buildingsController.clear();
    _floorsController.clear();
    _roomsController.clear();
  }
}
