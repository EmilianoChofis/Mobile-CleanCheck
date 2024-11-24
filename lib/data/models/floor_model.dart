import 'package:mobile_clean_check/data/models/building_model.dart';

class FloorModel {
  String? id;
  String name;
  String? buildingId;
  BuildingModel building;

  FloorModel({
    this.id,
    required this.name,
    this.buildingId,
    required this.building,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) {
    return FloorModel(
      id: json['id'],
      name: json['name'],
      buildingId: json['buildingId'],
      building: BuildingModel.fromJson(json['building']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'buildingId': buildingId,
      'building': building.toJson(),
    };
  }

  FloorModel copyWith({
    String? id,
    String? name,
    String? buildingId,
    BuildingModel? building,
  }) {
    return FloorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      buildingId: buildingId ?? this.buildingId,
      building: building ?? this.building,
    );
  }
}
