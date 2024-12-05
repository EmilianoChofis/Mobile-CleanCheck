import 'package:mobile_clean_check/data/models/models.dart';

class RoomModel {
  final String? id;
  final String identifier;
  final String name;
  final String? status;
  final String? floorId;
  final FloorModel? floor;

  RoomModel({
    this.id,
    required this.identifier,
    required this.name,
    this.status,
    this.floorId,
    this.floor,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      identifier: json['identifier'],
      name: json['name'],
      status: json['status'],
      floorId: json['floorId'],
      floor: json['floor'] != null
          ? FloorModel.fromJson(json['floor'])
          : FloorModel(name: 'Unknown'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'name': name,
      'status': status,
      'floorId': floorId,
      'floor': floor?.toJson(),
    };
  }

  RoomModel copyWith({
    String? id,
    String? identifier,
    String? name,
    String? status,
    String? floorId,
    FloorModel? floor,
  }) {
    return RoomModel(
      id: id ?? this.id,
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      status: status ?? this.status,
      floorId: floorId ?? this.floorId,
      floor: floor ?? this.floor,
    );
  }
}
