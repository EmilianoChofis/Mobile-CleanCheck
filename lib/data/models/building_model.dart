List<BuildingModel> buildingsFromJson(dynamic json) {
  return (json as List)
      .map((buildingJson) => BuildingModel.fromJson(buildingJson))
      .toList();
}

class BuildingModel {
  final String? id;
  final String name;
  final int number;

  BuildingModel({
    this.id,
    required this.name,
    required this.number,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
    };
  }

  BuildingModel copyWith({
    String? id,
    String? name,
    int? number,
  }) {
    return BuildingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
    );
  }
}
