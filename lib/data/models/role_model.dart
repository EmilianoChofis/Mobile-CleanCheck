class RoleModel {
  final String id;
  final String name;
  final String description;

  RoleModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}