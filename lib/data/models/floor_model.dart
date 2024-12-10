import 'package:mobile_clean_check/data/models/building_model.dart';
import 'package:mobile_clean_check/data/models/room_model.dart';

class FloorModel {
  String? id;
  String name;
  String? buildingId;
  BuildingModel? building;
  List<RoomModel>? rooms;

  FloorModel({
    this.id,
    required this.name,
    this.buildingId,
    this.building,
    this.rooms,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) {
    return FloorModel(
      id: json['id'],
      name: json['name'],
      buildingId: json['buildingId'],
      building: json['building'] != null
          ? BuildingModel.fromJson(json['building'])
          : null,
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
      'building': building?.toJson(),
      'rooms': rooms?.map((room) => room.toJson()).toList(),
    };
  }

  FloorModel copyWith({
    String? id,
    String? name,
    String? buildingId,
    BuildingModel? building,
    List<RoomModel>? rooms,
  }) {
    return FloorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      buildingId: buildingId ?? this.buildingId,
      building: building ?? this.building,
      rooms: rooms ?? this.rooms,
    );
  }
}
