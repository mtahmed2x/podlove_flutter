import 'dart:convert';

import 'package:dio/dio.dart';

PrivacyResposeModel privacyResposeModelFromJson(String str) =>
    PrivacyResposeModel.fromJson(json.decode(str));

class PrivacyResposeModel {
  bool success;
  String message;
  Data? data;

  PrivacyResposeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PrivacyResposeModel.fromJson(Response<dynamic> json) {
    final dataJson = json.data['data'];
    return PrivacyResposeModel(
      success: json.data['success'],
      message: json.data['message'],
      data: dataJson is Map<String, dynamic> && dataJson.isNotEmpty
          ? Data.fromJson(dataJson)
          : null,
    );
  }
}

class Data {
  String text;

  Data({
    required this.text,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        text: json["text"],
      );
}
