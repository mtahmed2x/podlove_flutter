import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/data/models/sign_up_response_model.dart';
import '../../data/services/api_service.dart';

class SignUpState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;
  final String? phoneNumber;
  final String? email;
  final SignUpResponseModel? response;

  SignUpState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
    this.phoneNumber,
    this.email,
    this.response,
  });

  factory SignUpState.initial() {
    return SignUpState(
      isLoading: false,
      isSuccess: null,
      error: null,
      phoneNumber: null,
      email: null,
      response: null,
    );
  }

  SignUpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? phoneNumber,
    String? email,
    SignUpResponseModel? response,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      phoneNumber: phoneNumber?? phoneNumber,
      email: email ?? email,
      error: error ?? error,
      response: response ?? response,
    );
  }
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final ApiService apiService;

  SignUpNotifier(this.apiService) : super(SignUpState());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  Future<void> signUp() async {
    final signUpData = {
      "name": nameController.text,
      "email": emailController.text,
      "role": "USER",
      "phoneNumber": phoneController.text,
      "password": passwordController.text,
      "confirmPassword": passwordController.text,
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        "/auth/register",
        data: signUpData,
      );
      final signUpResponse = SignUpResponseModel.fromJson(response);

      if(signUpResponse.statusCode == 201) {
        state = state.copyWith(
          isSuccess: true,
          error: null,
          isLoading: false,
          phoneNumber: signUpData["phoneNumber"],
          email: signUpData["email"]
        );
      }
      else if(signUpResponse.statusCode == 400) {
        state = state.copyWith(
          isSuccess: false,
          error: "Signup failed : ${signUpResponse.message}",
          isLoading: false,
        );
      }
      else if(signUpResponse.statusCode == 409) {
        final error = signUpResponse.data?.isVerified == true
            ? "Your account already exists. Please login."
            : "Your account already exists. Please verify.";
        state = state.copyWith(isSuccess: false, error: error, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isSuccess: false,
        error: "An unexpected error occurred. Please try again.",
        isLoading: false,
      );

    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
      (ref) {
    final apiService = ref.watch(apiServiceProvider);
    return SignUpNotifier(apiService);
  },
);

final apiServiceProvider = Provider<ApiService>((ref) {
  final apiService = ApiService.instance;
  apiService.init(baseUrl: 'http://10.0.60.41:7000/api/v1');
  return apiService;
});


