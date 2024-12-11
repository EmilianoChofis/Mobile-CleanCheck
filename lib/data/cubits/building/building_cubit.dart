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

  Future<void> getBuildingsActives() async {
    if (state is BuildingLoading) return;
    emit(BuildingLoading());
    loadBuildingsActives();
  }

  Future<void> loadBuildings() async {
    final response = await buildingRepository.getBuildings();

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingLoaded(buildings: response.data!));
    }
  }

  Future<void> loadBuildingsActives() async {
    final response = await buildingRepository.getBuildingsActives();

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingLoaded(buildings: response.data!));
    }
  }

  Future<void> loadBuildingsInactives() async {
    final response = await buildingRepository.getBuildingsInactives();

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingLoaded(buildings: response.data!));
    }
  }

  Future<BuildingModel?> getBuildingById(String buildingId) async {
    final response = await buildingRepository.getBuildingById(buildingId);

    if (response.error) {
      emit(BuildingError(message: response.message));
      return null;
    } else {
      emit(BuildingLoaded(buildings: [response.data!]));
      return response.data!;
    }
  }

  Future<void> createBuildingWithFloors(
      BuildingModel building, int newFloors) async {
    final response = await buildingRepository.createBuilding(building);

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      final createdBuilding = response.data;

      List<FloorModel> floors = List.generate(
        newFloors,
        (index) => FloorModel(
          name: 'Piso ${index + 1}',
          buildingId: createdBuilding!.id,
        ),
      );

      await FloorRepository().createListFloor(floors);

      emit(BuildingSuccess(message: response.message));
    }

    await loadBuildings();
  }

  Future<void> updateBuilding(BuildingModel building, int newFloors) async {
    final response = await buildingRepository.updateBuilding(building);

    if (response.error) {
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
      await FloorRepository().createListFloor(floors);
      await buildingRepository.updateBuilding(
        building.copyWith(number: lastFloor + building.number!),
      );
      emit(BuildingSuccess(message: response.message));
    }
    await loadBuildings();
  }

  Future<void> deleteBuilding(String buildingId) async {
    final response = await buildingRepository.deleteBuilding(buildingId);

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingSuccess(message: response.message));
    }

    await loadBuildings();
  }
}
