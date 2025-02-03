import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      error: error ?? this.error,
    );
  }
}

class VerifyCodeNotifier extends StateNotifier<VerifyCodeState> {
  final Ref ref;

  VerifyCodeNotifier(this.ref) : super(VerifyCodeState.initial());

  Future<void> verifyCode(Method method, String email, String otp) async {
    final apiService = ref.read(apiServiceProvider);
    state = state.copyWith(isLoading: true);

    try {
      if (method == Method.emailActivation ||
          method == Method.phoneActivation) {
        final activationData = {
          "method": method,
          "email": email,
          "verificationOTP": otp,
        };

        final response = await apiService.post(
          ApiEndpoints.activation,
          data: activationData,
        );
        logger.i(response);

        if (response.statusCode == StatusCode.OK) {
          final accessToken = response.data["data"]["accessToken"];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);

          logger.i(prefs.getString('accessToken'));

          final userJson = response.data["data"]["user"];
          ref.read(userProvider.notifier).initialize(userJson);
          state = state.copyWith(isSuccess: true, isLoading: false);
        }

        else if(response.statusCode == StatusCode.UNAUTHORIZED) {
          state = state.copyWith(isSuccess: false, error: response.data["message"]);
        }
      } else if (method == Method.emailRecovery ||
          method == Method.phoneRecovery) {
        final recoveryData = {
          "method": method,
          "email": email,
          "recoveryOTP": otp,
        };

        final response = await apiService.post(
          ApiEndpoints.recovery,
          data: recoveryData,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isSuccess: false,
        error: "An unexpected error occurred. Please try again.",
        isLoading: false,
      );
    }
  }

  Future<void> resendOTP(Method method, String email) async {

  }

}

final verifyCodeProvider =
    StateNotifierProvider<VerifyCodeNotifier, VerifyCodeState>(
  (ref) => VerifyCodeNotifier(ref),
);
