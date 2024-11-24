import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class FloorCubit extends Cubit<FloorState> {
  final FloorRepository floorRepository;

  FloorCubit({required this.floorRepository}) : super(FloorInitial());

  Future<void> createFloor(FloorModel floor) async {
    emit(FloorLoading());
    final response = await floorRepository.createFloor(floor);

    if (response.error) {
      emit(FloorError(message: response.message));
    } else {
      emit(FloorSuccess(message: 'Piso registrado con éxito'));
    }
  }
}