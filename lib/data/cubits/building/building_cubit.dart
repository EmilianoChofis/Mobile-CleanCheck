import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class BuildingCubit extends Cubit<BuildingState> {
  final BuildingRepository buildingRepository;

  BuildingCubit({required this.buildingRepository}) : super(BuildingInitial());

  Future<void> getBuildings() async {
    if (state is BuildingLoading) return;
    emit(BuildingLoading());
    loadBuildings();
  }

  Future<void> loadBuildings() async {
    final response = await buildingRepository.getBuildings();

    if (response.error && response.statusCode != 400) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingLoaded(buildings: response.data!));
    }
  }

  Future<void> createBuildingWithFloors(BuildingModel building) async {
    final response = await buildingRepository.createBuilding(building);

    if (response.error && response.statusCode != 400) {
      emit(BuildingError(message: response.message));
    } else {
      final createdBuilding = response.data;

      print('createdBuilding: $createdBuilding');

      List<FloorModel> floors = List.generate(
        createdBuilding!.number!,
        (index) => FloorModel(
          name: 'Piso ${index + 1}',
          buildingId: createdBuilding.id,
        ),
      );

      await FloorRepository().createListFloor(floors);

      emit(BuildingSuccess(
          message: 'Edificio creado y pisos añadidos con éxito'));
    }

    await loadBuildings();
  }

  Future<void> updateBuilding(BuildingModel building, int newFloors) async {

    print('building: $building, newFloors: $newFloors');

    final response = await buildingRepository.updateBuilding(building);

    if (response.error && response.statusCode != 400) {
      emit(BuildingError(message: response.message));
    } else {
      final createdBuilding = response.data!;
      final lastFloor = createdBuilding.floors!.length;

      List<FloorModel> floors = List.generate(
        newFloors,
        (index) => FloorModel(
          name: 'Piso ${lastFloor + index + 1}',
          buildingId: createdBuilding.id,
        ),
      );

      print(floors.toString());

      await FloorRepository().createListFloor(floors);
      await buildingRepository.updateBuilding(
        building.copyWith(number: lastFloor + building.number!),
      );
      emit(BuildingSuccess(message: 'Edificio actualizado con éxito'));
    }
    await loadBuildings();
  }
}
