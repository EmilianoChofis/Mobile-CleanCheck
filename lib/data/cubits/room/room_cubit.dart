import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepository roomRepository;

  RoomCubit({required this.roomRepository}) : super(RoomInitial());

  Future<void> getRooms(BuildingModel building) async {
    emit(RoomLoading());
    loadRooms(building.id!);
  }

  Future<void> loadRooms(String buildingId) async {
    final response = await roomRepository.getRoomsByBuildingId(buildingId);

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomLoaded(rooms: response.data!));
    }
  }

  Future<void> createListRooms(List<RoomModel> rooms) async {
    emit(RoomLoading());
    final response = await roomRepository.createListRooms(rooms);

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomSuccess(message: response.message));
    }

  }
}
