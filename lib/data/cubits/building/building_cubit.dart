import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class BuildingCubit extends Cubit<BuildingState> {
  final BuildingRepository buildingRepository;

  BuildingCubit({required this.buildingRepository}) : super(BuildingInitial());

  Future<void> getBuildings() async {
    emit(BuildingLoading());
    loadBuildings();
  }

  Future<void> loadBuildings() async {
    final response = await buildingRepository.getBuildings();

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingLoaded(buildings: response.data!));
    }
  }

  Future<void> createBuildingWithFloors(BuildingModel building) async {
    final response =
        await buildingRepository.createBuildingWithFloors(building);

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      final createdBuilding = response.data;

      List<FloorModel> floors = List.generate(
        createdBuilding!.number,
        (index) => FloorModel(
          name: 'Piso ${index + 1}',
          buildingId: createdBuilding.id,
          building: createdBuilding,
        ),
      );

      await FloorRepository().createListFloor(floors);

      emit(BuildingSuccess(
          message: 'Edificio creado y pisos añadidos con éxito'));
    }

    await loadBuildings();
  }

  Future<void> updateBuildingWithFloors(BuildingModel building) async {
    final response =
        await buildingRepository.updateBuildingWithFloors(building);

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      final createdBuilding = response.data;
      final buildingId = createdBuilding!.id;

      final floorsResponse =
          await FloorRepository().getFloorsByBuildingId(buildingId!);

      final lastFloor = floorsResponse.data!.length;

      List<FloorModel> floors = List.generate(
        createdBuilding.number,
        (index) => FloorModel(
          name: 'Piso ${lastFloor + index + 1}',
          buildingId: createdBuilding.id,
          building: createdBuilding,
        ),
      );

      await FloorRepository().createListFloor(floors);
      await buildingRepository.updateBuilding(
        building.copyWith(number: lastFloor + building.number),
      );

      emit(BuildingSuccess(message: 'Edificio actualizado con éxito'));
    }
    await loadBuildings();
  }
}
