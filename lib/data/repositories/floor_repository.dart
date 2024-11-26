import 'package:dio/dio.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class FloorRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse<FloorModel>> getFloorById(String id) async {
    try {
      final response = await dio.post(
        '/floor/findById',
        data: {'id': id},
      );

      return ApiResponse<FloorModel>(
        data: FloorModel.fromJson(response.data['data']),
        error: false,
        statusCode: 200,
        message: response.data['message'],
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

  Future<ApiResponse<List<FloorModel>>> getFloorsByBuildingId(
      String buildingId) async {
    try {
      final response = await dio.post(
        '/floor/getByBulding',
        data: {
          'buildingId': buildingId,
        },
      );

      final List<dynamic> data = response.data['data'];

      final List<FloorModel> floorModels =
          data.map((floorJson) => FloorModel.fromJson(floorJson)).toList();

      return ApiResponse<List<FloorModel>>(
        data: floorModels,
        error: false,
        statusCode: 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse<List<FloorModel>>(
        data: [],
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<List<FloorModel>>> createListFloor(
      List<FloorModel> floors) async {
    try {
      final response = await dio.post(
        '/floor/create-list',
        data: {
          'floors': floors.map((floor) => floor.toJson()).toList(),
        },
      );

      final List<dynamic> data = response.data['data'];

      final List<FloorModel> floorModels =
          data.map((floorJson) => FloorModel.fromJson(floorJson)).toList();

      return ApiResponse<List<FloorModel>>(
        data: floorModels,
        error: false,
        statusCode: 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse<List<FloorModel>>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }
}
