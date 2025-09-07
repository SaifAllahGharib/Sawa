import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClint {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: {
          'Content-Type': 'application/json',
          'apikey': dotenv.env['SUPABASE_KEY']!,
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    return dio;
  }
}
