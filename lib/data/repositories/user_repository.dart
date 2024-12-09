import 'package:dio/dio.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class UserRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse<List<UserModel>>> getUsers() async {
    try {
      final response = await dio.get('/user/getAll');
      return ApiResponse<List<UserModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => UserModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<UserModel>>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<UserModel>> createUser(UserModel user, String role) async {
    try {
      final response =
          await dio.post('/auth/createUser/$role', data: user.toJson());
      return ApiResponse<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<UserModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<UserModel>> updateUser(UserModel user) async {
    try {
      final response = await dio.put('/user/update', data: user.toJson());
      return ApiResponse<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<UserModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<UserModel>> deleteUser(String id) async {
    try {
      final response = await dio.put('/user/changeStatus/$id');
      return ApiResponse<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<UserModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }
}
