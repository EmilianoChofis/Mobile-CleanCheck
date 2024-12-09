
import 'package:mobile_clean_check/data/models/room_model.dart';

class FloorModel {
  String? id;
  String name;
  String? buildingId;
  List<RoomModel>? rooms;

  FloorModel({
    this.id,
    required this.name,
    this.buildingId,
    this.rooms,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) {
    return FloorModel(
      id: json['id'],
      name: json['name'],
      buildingId: json['buildingId'],
      rooms: json['rooms'] != null
          ? (json['rooms'] as List)
              .map((roomJson) => RoomModel.fromJson(roomJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'buildingId': buildingId,
      'rooms': rooms?.map((room) => room.toJson()).toList(),
    };
  }

  FloorModel copyWith({
    String? id,
    String? name,
    String? buildingId,
    List<RoomModel>? rooms,
  }) {
    return FloorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      buildingId: buildingId ?? this.buildingId,
      rooms: rooms ?? this.rooms,
    );
  }
}
