import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= Dio(BaseOptions(
      baseUrl: 'http://98.85.18.206:8082/api-clean',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    return _dio!;
  }
}
