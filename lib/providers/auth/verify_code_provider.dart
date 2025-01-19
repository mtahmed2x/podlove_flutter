import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/data/models/sign_up_response_model.dart';
import '../../data/services/api_service.dart';

class VerifyCodeState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;
  final SignUpResponseModel? response;

  VerifyCodeState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
    this.response,
  });

  factory VerifyCodeState.initial() {
    return VerifyCodeState(
      isLoading: false,
      isSuccess: null,
      error: null,
      response: null,
    );
  }

  VerifyCodeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? phoneNumber,
    String? email,
    SignUpResponseModel? response,
  }) {
    return VerifyCodeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? error,
      response: response ?? response,
    );
  }
}

class VerifyCodeNotifier extends StateNotifier<VerifyCodeState> {
  final ApiService apiService;

  VerifyCodeNotifier(this.apiService) : super(VerifyCodeState());

  final otpController = TextEditingController();


  Future<void> verifyCode(String phoneNumber) async {
    final signUpData = {
      "phoneNumber": phoneNumber,
      "verificationOTP": otpController.text,
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


