import 'package:dio/dio.dart';

class SignInResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data? data;

  SignInResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  factory SignInResponseModel.fromJson(Response<dynamic> json) {
    final dataJson = json.data['data'];
    return SignInResponseModel(
      statusCode: json.statusCode!,
      success: json.data['success'],
      message: json.data['message'],
      data: dataJson is Map<String, dynamic> && dataJson.isNotEmpty
          ? Data.fromJson(dataJson)
          : null,
    );
  }
}

class Data {
  final String accessToken;

  Data({
    required this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accessToken: json['accessToken'] ?? '',
    );
  }
}
