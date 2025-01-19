import 'package:dio/dio.dart';

class SignUpResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data? data;

  SignUpResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  factory SignUpResponseModel.fromJson(Response<dynamic> json) {
    final dataJson = json.data['data'];
    return SignUpResponseModel(
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
  final bool isVerified;
  final String verificationOtp;

  Data({
    required this.isVerified,
    required this.verificationOtp,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      isVerified: json['isVerified'] ?? false,
      verificationOtp: json['verificationOtp'] ?? '',
    );
  }
}

