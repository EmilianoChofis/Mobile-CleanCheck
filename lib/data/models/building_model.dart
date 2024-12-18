import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/models/status_aware.dart';

List<BuildingModel> buildingsFromJson(dynamic json) {
  return (json as List)
      .map((buildingJson) => BuildingModel.fromJson(buildingJson))
      .toList();
}

class BuildingModel implements StatusAware {
  final String? id;
  final String name;
  final int? number;
  final List<FloorModel>? floors;

  @override
  final bool? status;

  BuildingModel({
    this.id,
    required this.name,
    this.number,
    this.status,
    this.floors,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      status: json['status'],
      floors: json['floors'] != null
          ? (json['floors'] as List)
              .map((floorJson) => FloorModel.fromJson(floorJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'status': status,
      'floors': floors?.map((floor) => floor.toJson()).toList(),
    };
  }

  BuildingModel copyWith({
    String? id,
    String? name,
    int? number,
    bool? status,
    List<FloorModel>? floors,
  }) {
    return BuildingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      status: status ?? this.status,
      floors: floors ?? this.floors,
    );
  }
}
