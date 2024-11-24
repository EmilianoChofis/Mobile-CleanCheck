import 'package:dio/dio.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class FloorRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse<FloorModel>> createFloor(FloorModel floor) async {
    try {
      final response = await dio.post(
        '/floor/create',
        data: floor.toJson(),
      );

      return ApiResponse<FloorModel>.fromJson(
        response.data,
        (json) => FloorModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<FloorModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }
}