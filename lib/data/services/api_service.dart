import 'package:dio/dio.dart';
import 'api_exceptions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  ApiService._privateConstructor();
  static final ApiService instance = ApiService._privateConstructor();

  late Dio _dio;

  void init({required String baseUrl, Map<String, dynamic>? headers}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: headers ?? {
        'Content-Type': 'application/json',
      },
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // options.headers['Authorization'] = 'Bearer your_token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // You can handle global responses here
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Handle errors globally
          throw _handleDioError(e);
        },
      ),
    );
  }

  Future<T> getRequest<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      Response<T> response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> postRequest<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      Response<T> response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> putRequest<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      Response<T> response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> deleteRequest<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      Response<T> response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data!;
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
        {
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
        }
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return NoInternetException("No Internet connection");
      }
  }
}
