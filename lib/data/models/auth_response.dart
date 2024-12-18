import 'package:mobile_clean_check/data/models/models.dart';

class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: UserModel.fromJson(json['user'],
      ),
    );
  }
}
