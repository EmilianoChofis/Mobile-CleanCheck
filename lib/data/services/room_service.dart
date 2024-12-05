import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class RoomService {
  Future<List<RoomModel>> generateRooms({
    required String floorId,
    required int lastRoomNumber,
    required int newRooms,
    required String floorControllerText,
    required String roomsControllerText,
  }) async {
    final response = await FloorRepository().getFloorById(floorId);

    final foundFloor = response.data!.name;
    final selectedFloor = foundFloor.split(' ');
    final firstLetter = selectedFloor[0].substring(0, 1);
    final floorName = firstLetter + selectedFloor[1];

    return List.generate(
      newRooms,
      (index) {
        final roomNumber = lastRoomNumber + index + 1;
        return RoomModel(
          identifier: floorName,
          name: '${floorName}H$roomNumber',
          floorId: floorId,
        );
      },
    );
  }
}
