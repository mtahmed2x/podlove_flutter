import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/Response/reset_password_response_model.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class ResetPasswordState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  ResetPasswordState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  ResetPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final ApiServices apiService;

  ResetPasswordNotifier(this.apiService) : super(ResetPasswordState());

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    final resetPasswordData = {
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        ApiEndpoints.resetPassword,
        data: resetPasswordData,
      );
      logger.i(response);
      final ResetPasswordResponseModel resetPasswordResponse =
          ResetPasswordResponseModel.fromJson(response);

      if (resetPasswordResponse.success == true) {
        state = state.copyWith(isSuccess: true);
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return ResetPasswordNotifier(apiService);
  },
);
