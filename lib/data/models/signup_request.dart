import 'dart:convert';

import 'package:podlove_flutter/data/models/base_model.dart';

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  final String name;
  final String email;
  final String role;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {

  };

}
