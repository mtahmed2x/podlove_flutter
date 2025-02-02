import 'package:dio/dio.dart';

class ApiExceptionHandler {
  static ApiException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ApiException("Request was cancelled.");
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException("Connection timed out. Please try again.");
      case DioExceptionType.badResponse:
        int? statusCode = error.response?.statusCode;
        String message =
            error.response?.data?['message'] ?? "Something went wrong";
        return _mapHttpException(statusCode, message);
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return NoInternetException("No internet connection.");
    }
  }

  static ApiException _mapHttpException(int? statusCode, String message) {
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
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message);
}

class InternalServerException extends ApiException {
  InternalServerException(super.message);
}

class NoInternetException extends ApiException {
  NoInternetException(super.message);
}

class TimeoutException extends ApiException {
  TimeoutException(super.message);
}
