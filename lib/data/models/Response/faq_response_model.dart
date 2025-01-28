import 'dart:convert';

import 'package:dio/dio.dart';

FAQResposeModel faqResponseModelFromJson(String str) =>
    FAQResposeModel.fromJson(json.decode(str));

class FAQResposeModel {
  bool success;
  String message;
  List<Data>? data;

  FAQResposeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FAQResposeModel.fromJson(Response<dynamic> json) {
    final dataJson = json.data['data'];
    return FAQResposeModel(
      success: json.data['success'],
      message: json.data['message'],
      data: dataJson is List<dynamic>
          ? dataJson.map((item) => Data.fromJson(item)).toList()
          : null,
    );
  }
}

class Data {
  String question;
  String answer;

  Data({
    required this.question,
    required this.answer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        question: json["question"] ?? "",
        answer: json["answer"] ?? "",
      );
}
