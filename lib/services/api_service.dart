import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  late final Dio _dio;

  Future<ApiService> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://api.example.com", // Replace with your API base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    return this;
  }

  Future<T> get<T>(String endpoint,
      {Map<String, dynamic>? queryParameters,
        Options? options,
        T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      if (fromJson != null) {
        return fromJson(response.data!);
      }
      return response.data as T;
    } on DioError catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<T> post<T>(String endpoint,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      if (fromJson != null) {
        return fromJson(response.data!);
      }
      return response.data as T;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<T> put<T>(String endpoint,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      if (fromJson != null) {
        return fromJson(response.data!);
      }
      return response.data as T;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<T> delete<T>(String endpoint,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      if (fromJson != null) {
        return fromJson(response.data!);
      }
      return response.data as T;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException error) {
    if (error.response != null) {
      print("Error: ${error.response?.statusCode} - ${error.response?.data}");
    } else {
      print("Error: ${error.message}");
    }
  }
}

class ApiBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync(() => ApiService().init());
  }
}
