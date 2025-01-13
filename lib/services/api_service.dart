import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse, // Correct type based on Dio version
          error: "Request failed with status: ${response.statusCode}",
        );
      }
    } on DioException catch (dioError) {
      print('DioError: ${dioError.response?.data ?? dioError.message}');
      throw dioError;
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception("An unexpected error occurred");
    }
  }
}
