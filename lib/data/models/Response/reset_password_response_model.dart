import 'package:dio/dio.dart';

class ResetPasswordResponseModel {
  final int statusCode;
  final bool success;
  final String message;

  ResetPasswordResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Response<dynamic> json) {
    return ResetPasswordResponseModel(
      statusCode: json.statusCode!,
      success: json.data['success'],
      message: json.data['message'],
    );
  }
}
