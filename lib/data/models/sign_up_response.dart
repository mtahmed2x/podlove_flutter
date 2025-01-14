import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

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

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final bool isVerified;

  Data({
    required this.isVerified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isVerified: json["isVerified"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "isVerified": isVerified,
      };
}
