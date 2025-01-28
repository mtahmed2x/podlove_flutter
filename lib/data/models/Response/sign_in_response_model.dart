import 'package:dio/dio.dart';
import 'package:podlove_flutter/data/models/auth_model.dart';
import 'package:podlove_flutter/data/models/user_model.dart';

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
  final AuthModel auth;
  final UserModel user;

  Data({
    required this.accessToken,
    required this.auth,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        auth: AuthModel.fromJson(json["auth"]),
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "auth": auth.toJson(),
        "user": user.toJson(),
      };
}
