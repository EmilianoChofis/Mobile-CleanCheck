import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static Dio? _dio;

  final apiUrl = dotenv.env['API_URL'].toString();

  Dio get instance {
    _dio ??= Dio(BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    return _dio!;
  }
}
