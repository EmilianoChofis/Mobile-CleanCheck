import 'package:dio/dio.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/data/models/api_response.dart';
import 'package:mobile_clean_check/data/models/room_model.dart';

class RoomRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse<List<RoomModel>>> getRoomsByBuildingId(
      String buildingId) async {
    try {
      final response = await dio.post(
        '/room/getByBuilding',
        data: {'buildingId': buildingId},
      );

      return ApiResponse<List<RoomModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => RoomModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<RoomModel>>(
        data: [],
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<List<RoomModel>>> getCleanedRooms() async {
    try {
      final response = await dio.get('/room/getAllClean');
      return ApiResponse<List<RoomModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => RoomModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<RoomModel>>(
        data: [],
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<List<RoomModel>>> createListRooms(
      List<RoomModel> rooms) async {
    try {
      final response = await dio.post(
        '/room/createList',
        data: rooms.map((room) => room.toJson()).toList(),
      );

      final List<dynamic> data = response.data['data'];

      final List<RoomModel> roomModels =
          data.map((roomJson) => RoomModel.fromJson(roomJson)).toList();

      return ApiResponse<List<RoomModel>>(
        data: roomModels,
        error: false,
        statusCode: 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse<List<RoomModel>>(
        data: [],
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<RoomModel>> changeClean(String roomId) async {
    try {
      final response = await dio.put('/room/changeStatusClean/$roomId');
      return ApiResponse<RoomModel>(
        data: RoomModel.fromJson(response.data['data']),
        error: false,
        statusCode: 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse<RoomModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<RoomModel>> changeCheckIn(String roomId) async {
    try {
      final response = await dio.put('/room/changeStatusOccupied/$roomId');
      return ApiResponse<RoomModel>(
        data: RoomModel.fromJson(response.data['data']),
        error: false,
        statusCode: 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse<RoomModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<RoomModel>> changeCheckOut(String roomId) async {
    try {
      final response = await dio.put('/room/changeStatusUnoccupied/$roomId');
      return ApiResponse<RoomModel>(
        data: RoomModel.fromJson(response.data['data']),
        error: false,
        statusCode: 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse<RoomModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<RoomModel>> changeChecked(String roomId) async {
    try {
      final response = await dio.put('/room/changeStatusChecked/$roomId');
      return ApiResponse<RoomModel>(
        data: RoomModel.fromJson(response.data['data']),
        error: false,
        statusCode: 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse<RoomModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }
}
