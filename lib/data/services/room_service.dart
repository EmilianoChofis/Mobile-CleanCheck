import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class RoomService {
  Future<List<RoomModel>> generateRooms({
    required String floorId,
    required String floorControllerText,
    required String roomsControllerText,
  }) async {
    final response = await FloorRepository().getFloorById(floorId);
    if (response.data == null) throw Exception('Piso no encontrado');

    final foundFloor = response.data!.name;
    final selectedFloor = foundFloor.split(' ');
    final firstLetter = selectedFloor[0].substring(0, 1);
    final floorName = firstLetter + selectedFloor[1];
    final numberOfRooms = int.tryParse(roomsControllerText.trim()) ?? 0;

    return List.generate(
      numberOfRooms,
          (index) {
        final roomNumber = index + 1;
        return RoomModel(
          identifier: floorName,
          name: '${floorName}H$roomNumber',
          floor: FloorModel(
            id: floorId,
            name: floorName,
          ),
        );
      },
    );
  }
}
