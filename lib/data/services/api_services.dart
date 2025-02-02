import 'package:dio/dio.dart';
import 'package:podlove_flutter/data/services/api_exceptions.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServices {
  ApiServices._privateConstructor();
  static final ApiServices instance = ApiServices._privateConstructor();

  late Dio _dio;
  bool _isInitialized = false;

  Future<void> init({
    required String baseUrl,
    Map<String, dynamic>? headers,
  }) async {
    if (_isInitialized) return;

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: headers ?? {'Content-Type': 'application/json'},
      validateStatus: (status) => status! < 500,
    );

    _dio = Dio(options);

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('accessToken') ?? "No Token Found";
        options.headers['Authorization'] = 'Bearer $token';

        logger.i("🔑 Sending Request with Access Token: $token");
        logger.i("📤 Request URL: ${options.uri}");
        logger.i("📦 Request Headers: ${options.headers}");

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    ));

    _isInitialized = true;
  }

  Dio get dio {
    if (!_isInitialized) {
      throw Exception("ApiServices is not initialized. Call init() first.");
    }
    return _dio;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiExceptionHandler.handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiExceptionHandler.handleDioError(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiExceptionHandler.handleDioError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiExceptionHandler.handleDioError(e);
    }
  }
}
