import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/data/models/Response/verify_code_response_model.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class VerifyCodeState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  VerifyCodeState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory VerifyCodeState.initial() {
    return VerifyCodeState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  VerifyCodeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return VerifyCodeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? error,
    );
  }
}

class VerifyCodeNotifier extends StateNotifier<VerifyCodeState> {
  final ApiServices apiService;

  VerifyCodeNotifier(this.apiService) : super(VerifyCodeState());

  final otpController = TextEditingController();

  Future<void> verifyCode(String email) async {
    final verifyCodeData = {
      "email": email,
      "verificationOTP": otpController.text,
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        "/auth/activate",
        data: verifyCodeData,
      );
      logger.i(response);

      final verifyCodeResponse = VerifyCodeResponseModel.fromJson(response);
      logger.i(verifyCodeResponse.data!.auth.email);
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
    otpController.dispose();
    super.dispose();
  }
}

final verifyCodeProvider =
    StateNotifierProvider<VerifyCodeNotifier, VerifyCodeState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return VerifyCodeNotifier(apiService);
  },
);
