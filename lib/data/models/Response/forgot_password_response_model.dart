import 'package:dio/dio.dart';

class ForgotPasswordResponseModel {
  final int statusCode;
  final bool success;
  final String message;

  ForgotPasswordResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory ForgotPasswordResponseModel.fromJson(Response<dynamic> json) {
    return ForgotPasswordResponseModel(
      statusCode: json.statusCode!,
      success: json.data['success'],
      message: json.data['message'],
    );
  }
}
