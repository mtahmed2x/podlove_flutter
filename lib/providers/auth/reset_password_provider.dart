import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/Response/forgot_password_response_model.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class ForgotPasswordState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  ForgotPasswordState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final ApiServices apiService;

  ForgotPasswordNotifier(this.apiService) : super(ForgotPasswordState());

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> forgotPassword() async {
    final forgotPasswordData = {
      "email": emailController.text,
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        ApiEndpoints.forgotPassword,
        data: forgotPasswordData,
      );
      logger.i(response);
      final ForgotPasswordResponseModel forgotPasswordResponse =
          ForgotPasswordResponseModel.fromJson(response);

      if (forgotPasswordResponse.success == true) {
        state =
            state.copyWith(isSuccess: true, email: forgotPasswordData["email"]);
      }
    } catch (e) {
      state = state.copyWith(
        isSuccess: false,
        error: "An unexpected error occurred. Please try again.",
        isLoading: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return ForgotPasswordNotifier(apiService);
  },
);
