import 'package:dio/dio.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/data/models/models.dart';

class ReportRepository {
  final Dio dio = DioClient.instance;

  Future<ApiResponse<List<ReportModel>>> getReports() async {
    try {
      final response = await dio.get('/report/getAll');
      return ApiResponse<List<ReportModel>>.fromJson(
        response.data,
        (json) =>
            (json as List).map((json) => ReportModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<ReportModel>>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<ReportModel>> createReport(ReportModel report) async {
    try {
      final response = await dio.post(
        '/report/create',
        data: report.toJson(),
      );
      return ApiResponse<ReportModel>.fromJson(
        response.data,
        (json) => ReportModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<ReportModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }

  Future<ApiResponse<ReportModel>> changeStatusIn(String reportId) async {
    try {
      final response = await dio.put('/report/updateStatusIn/$reportId');
      return ApiResponse<ReportModel>.fromJson(
        response.data,
        (json) => ReportModel.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<ReportModel>(
        data: null,
        error: true,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ??
            'Ha ocurrido un error. Inténtalo de nuevo.',
      );
    }
  }
}
