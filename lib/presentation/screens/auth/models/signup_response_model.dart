import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  final bool? success;
  final String? message;
  final Data? data;

  SignUpResponse({
    this.success,
    this.message,
    this.data,
  });

  SignUpResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      SignUpResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final bool? isVerified;

  Data({
    this.isVerified,
  });

  Data copyWith({
    bool? isVerified,
  }) =>
      Data(
        isVerified: isVerified ?? this.isVerified,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isVerified: json["isVerified"],
  );

  Map<String, dynamic> toJson() => {
    "isVerified": isVerified,
  };
}
