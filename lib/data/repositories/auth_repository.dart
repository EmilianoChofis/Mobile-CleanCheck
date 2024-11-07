import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';

class AuthRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse> login(AuthModel auth) async {
    try {
      final response = await dio.post(
        '/auth/signIn',
        data: json.encode(auth.toJson()),
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }
}
