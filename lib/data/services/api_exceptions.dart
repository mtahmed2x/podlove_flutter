import 'package:dio/dio.dart';

class ApiExceptionHandler {
  static ApiException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return RequestCancelledException("Request was cancelled.");
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException("Connection timed out. Please try again.");
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return NoInternetException("No internet connection.");
      case DioExceptionType.badResponse:
        int? statusCode = error.response?.statusCode;
        String message =
            error.response?.data?['message'] ?? "Something went wrong";
        return InternalServerException(message);
      }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class RequestCancelledException extends ApiException {
  RequestCancelledException(super.message);
}

class TimeoutException extends ApiException {
  TimeoutException(super.message);
}

class NoInternetException extends ApiException {
  NoInternetException(super.message);
}

class InternalServerException extends ApiException {
  InternalServerException(super.message);
}