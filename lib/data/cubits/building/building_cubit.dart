import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class BuildingCubit extends Cubit<BuildingState> {
  final BuildingRepository buildingRepository;

  BuildingCubit({required this.buildingRepository}) : super(BuildingInitial());

  Future<void> getBuildings() async {
    emit(BuildingLoading());
    final response = await buildingRepository.getBuildings();

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingLoaded(buildings: response.data!));
    }
  }

  Future<void> createBuilding(BuildingModel building) async {
    final response = await buildingRepository.createBuilding(building);

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingSuccess(message: 'Edificio registrado con éxito'));
      await getBuildings();
    }
  }

  Future<void> updateBuilding(BuildingModel building) async {
    final response = await buildingRepository.updateBuilding(building);

    if (response.error) {
      emit(BuildingError(message: response.message));
    } else {
      emit(BuildingSuccess(message: 'Edificio actualizado con éxito'));
      await getBuildings();
    }
  }
}
