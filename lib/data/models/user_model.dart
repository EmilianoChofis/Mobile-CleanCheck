import 'package:mobile_clean_check/data/models/role_model.dart';
import 'package:mobile_clean_check/data/models/status_aware.dart';

class UserModel implements StatusAware {
  final String? id;
  final String name;
  final String email;
  final String? password;
  final String? createdAt;
  final bool? blocked;
  final RoleModel role;

  @override
  final bool? status;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.password,
    this.createdAt,
    this.status,
    this.blocked,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      createdAt: json['createdAt'],
      status: json['status'],
      blocked: json['blocked'],
      role: RoleModel.fromJson(json['role']),
    );
  }
}
