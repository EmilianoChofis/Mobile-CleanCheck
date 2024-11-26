import 'package:mobile_clean_check/data/models/models.dart';

class RoomModel {
  final String? id;
  final String identifier;
  final String name;
  final String? status;
  final FloorModel floor;

  RoomModel({
    this.id,
    required this.identifier,
    required this.name,
    this.status,
    required this.floor,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      identifier: json['identifier'],
      name: json['name'],
      status: json['status'],
      floor: FloorModel.fromJson(json['floor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'name': name,
      'status': status,
      'floor': floor.toJson(),
    };
  }

  RoomModel copyWith({
    String? id,
    String? identifier,
    String? name,
    String? status,
    FloorModel? floor,
  }) {
    return RoomModel(
      id: id ?? this.id,
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      status: status ?? this.status,
      floor: floor ?? this.floor,
    );
  }
}
