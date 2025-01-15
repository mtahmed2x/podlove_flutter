import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

class SignUpResponse {
  final bool success;
  final String message;
  final Data? data;

  SignUpResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] is Map<String, dynamic> && json["data"].isNotEmpty
            ? Data.fromJson(json["data"])
            : null,
      );

}

class Data {
  final bool isVerified;

  Data({
    required this.isVerified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isVerified: json["isVerified"] ?? false,
      );
}
