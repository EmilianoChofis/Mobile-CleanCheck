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
}
