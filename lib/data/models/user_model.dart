import 'package:mobile_clean_check/data/models/role_model.dart';
import 'package:mobile_clean_check/data/models/status_aware.dart';

class UserModel implements StatusAware {
  final String? id;
  final String name;
  final String email;
  final String? password;
  final String? createdAt;
  final bool? blocked;
  final String? roleId;
  final RoleModel? role;

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
    this.roleId,
    this.role,
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
      roleId: json['roleId'],
      role: RoleModel.fromJson(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'status': status,
      'blocked': blocked,
      'roleId': roleId,
      'role': role,
    };
  }
}
