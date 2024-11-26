import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class FloorCubit extends Cubit<FloorState> {
  final FloorRepository floorRepository;

  FloorCubit({required this.floorRepository}) : super(FloorInitial());

  Future<void> createListFloor(List<FloorModel> floors) async {
    emit(FloorLoading());
    final response = await floorRepository.createListFloor(floors);

    if (response.error) {
      emit(FloorError(message: response.message));
    } else {
      emit(FloorSuccess(message: 'Pisos registrados con éxito'));
    }
  }

  Future<void> getFloorsByBuildingId(String buildingId) async {
    emit(FloorLoading());

    final response = await floorRepository.getFloorsByBuildingId(buildingId);

    if (response.error) {
      emit(FloorError(message: response.message));
    } else {
      emit(FloorLoaded(floors: response.data!));
    }
  }
}
