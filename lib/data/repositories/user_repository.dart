import 'package:dio/dio.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class UserRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse<List<UserModel>>> getUsers() async {
    try {
      final response = await dio.post(
        '/user/getAll',
        data: {
          "paginationType": {
            "filter": "name",
            "limit": 5,
            "order": "asc",
            "page": 0,
            "sortBy": "name"
          },
          "value": ""
        },
      );
      print('response: ${response.data}');

      return ApiResponse<List<UserModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => UserModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      print('error: ${e.response?.data}');
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
