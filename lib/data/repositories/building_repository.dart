import 'package:dio/dio.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class BuildingRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse<List<BuildingModel>>> getBuildings() async {
    try {
      final response = await dio.get('/building/getAll');

      return ApiResponse<List<BuildingModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => BuildingModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<BuildingModel>>(
        data: [],
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<List<BuildingModel>>> getBuildingsActives() async {
    try {
      final response = await dio.get('/building/getAllActive');
      return ApiResponse<List<BuildingModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => BuildingModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<BuildingModel>>(
        data: [],
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<List<BuildingModel>>> getBuildingsInactives() async {
    try {
      final response = await dio.get('/building/getAllInactive');
      return ApiResponse<List<BuildingModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => BuildingModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<BuildingModel>>(
        data: [],
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<BuildingModel>> getBuildingById(String buildingId) async {
    try {
      final response = await dio.get('/building/getById/$buildingId');
      return ApiResponse<BuildingModel>.fromJson(
        response.data,
        (json) => BuildingModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<BuildingModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<BuildingModel>> createBuilding(
      BuildingModel building) async {
    try {
      final response = await dio.post(
        '/building/create',
        data: building.toJson(),
      );

      return ApiResponse<BuildingModel>.fromJson(
          response.data, (json) => BuildingModel.fromJson(json));
    } on DioException catch (e) {
      return ApiResponse<BuildingModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<BuildingModel>> updateBuilding(
      BuildingModel building) async {
    try {
      final response = await dio.put(
        '/building/update',
        data: building.toJson(),
      );

      return ApiResponse<BuildingModel>.fromJson(
        response.data,
        (json) => BuildingModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<BuildingModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<BuildingModel>> deleteBuilding(String buildingId) async {
    try {
      final response = await dio.put('/building/changeStatus/$buildingId');

      return ApiResponse<BuildingModel>.fromJson(
        response.data,
        (json) => BuildingModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<BuildingModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }
}
