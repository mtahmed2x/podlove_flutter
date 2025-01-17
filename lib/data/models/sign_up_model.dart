import 'dart:convert';

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  final String name;
  final String email;
  final String role;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String? signUpError;

  SignUpModel({
    this.name = "",
    this.email = "",
    this.role = "",
    this.phoneNumber = "",
    this.password = "",
    this.confirmPassword = "",
    this.isLoading = false,
    this.signUpError,
  });

  SignUpModel copyWith({
    String? name,
    String? email,
    String? role,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? signUpError,
  }) =>
      SignUpModel(
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isLoading: isLoading ?? this.isLoading,
        signUpError: signUpError ?? this.signUpError,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "role": role,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
      };
}
