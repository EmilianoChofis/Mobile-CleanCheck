import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepository roomRepository;

  RoomCubit({required this.roomRepository}) : super(RoomInitial());

  Future<void> getRoomsByBuildingId(String buildingId) async {
    emit(RoomLoading());
    final response = await roomRepository.getRoomsByBuildingId(buildingId);

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomLoaded(rooms: response.data!));
    }
  }

  Future<void> getCleanedRooms() async {
    final response = await roomRepository.getCleanedRooms();

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomClean(rooms: response.data!));
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

  Future<void> changeClean(String roomId) async {
    emit(RoomLoading());
    final response = await roomRepository.changeClean(roomId);

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomSuccess(message: response.message));
    }
  }

  Future<void> changeCheckIn(String roomId) async {
    emit(RoomLoading());
    final response = await roomRepository.changeCheckIn(roomId);

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomSuccess(message: response.message));
    }
  }

  Future<void> changeCheckOut(String roomId) async {
    emit(RoomLoading());
    final response = await roomRepository.changeCheckOut(roomId);

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomSuccess(message: response.message));
    }
  }

  Future<void> changeChecked(String roomId) async {
    emit(RoomLoading());
    final response = await roomRepository.changeChecked(roomId);

    if (response.error) {
      emit(RoomError(message: response.message));
    } else {
      emit(RoomSuccess(message: response.message));
    }
  }
}
