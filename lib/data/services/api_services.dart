import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_exceptions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServices {
  ApiServices._privateConstructor();
  static final ApiServices instance = ApiServices._privateConstructor();

  late Dio _dio;
  bool _isInitialized = false; // Track if _dio is initialized

  Future<void> init({required String baseUrl, Map<String, dynamic>? headers}) async {
    if (_isInitialized) return; // Prevent multiple initializations

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: headers ?? {
        'Content-Type': 'application/json',
      },
      validateStatus: (status) {
        return status! < 500;
      },
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
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $token';
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
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      return await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      return await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> patch<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      return await dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> delete<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ApiException("Request to API server was cancelled");
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException("Connection Timeout with API server");
      case DioExceptionType.badResponse:
        int? statusCode = error.response?.statusCode;
        String message = error.response?.statusMessage ?? "Something went wrong";
        switch (statusCode) {
          case 400:
            return BadRequestException(message);
          case 401:
          case 403:
            return UnauthorizedException(message);
          case 404:
            return NotFoundException(message);
          case 500:
            return InternalServerException(message);
          default:
            return ApiException(message);
        }
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return NoInternetException("No Internet connection");
    }
  }
}
