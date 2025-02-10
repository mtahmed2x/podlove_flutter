import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyCodeState {
  final bool isLoading;
  final bool? isVerificationSuccess;
  final bool? isPhoneSuccess;
  final bool? isResendSuccess;
  final String? error;

  VerifyCodeState({
    this.isLoading = false,
    this.isVerificationSuccess,
    this.isPhoneSuccess,
    this.isResendSuccess,
    this.error,
  });

  factory VerifyCodeState.initial() {
    return VerifyCodeState(
      isLoading: false,
      isVerificationSuccess: null,
      isPhoneSuccess: null,
      isResendSuccess: null,
      error: null,
    );
  }

  VerifyCodeState copyWith({
    bool? isLoading,
    bool? isVerificationSuccess,
    bool? isPhoneSuccess,
    bool? isResendSuccess,
    String? error,
  }) {
    return VerifyCodeState(
      isLoading: isLoading ?? this.isLoading,
      isVerificationSuccess:
          isVerificationSuccess ?? this.isVerificationSuccess,
      isPhoneSuccess: isPhoneSuccess ?? this.isPhoneSuccess,
      isResendSuccess: isResendSuccess ?? this.isResendSuccess,
      error: error ?? this.error,
    );
  }
}

class VerifyCodeNotifier extends StateNotifier<VerifyCodeState> {
  final Ref ref;

  VerifyCodeNotifier(this.ref) : super(VerifyCodeState.initial());

  Future<void> verifyCode(Method method, String email, String otp) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);
    try {
      if (method == Method.emailActivation ||
          method == Method.phoneActivation) {
        final activationData = {
          "email": email,
          "verificationOTP": otp,
        };

        final response = await apiService.post(
          ApiEndpoints.activate,
          data: activationData,
        );

        if (response.statusCode == StatusCode.OK) {
          final accessToken = response.data["data"]["accessToken"];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);

          final userJson = response.data["data"]["user"];
          ref.read(userProvider.notifier).initialize(userJson);

          state = state.copyWith(isVerificationSuccess: true);
        } else if (response.statusCode == StatusCode.UNAUTHORIZED) {
          state = state.copyWith(
              isVerificationSuccess: false, error: response.data["message"]);
        }
      } else if (method == Method.emailRecovery) {
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
        isVerificationSuccess: false,
        error: "An unexpected error occurred. Please try again.",
        isLoading: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resendOTP(String method, String email) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);

    try {
      final resendOTPData = {
        "method": method,
        "email": email,
      };

      final response = await apiService.post(
        ApiEndpoints.resendOTP,
        data: resendOTPData,
      );

      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(isResendSuccess: true);
      }
    } catch (e) {
      state = state.copyWith(
        isPhoneSuccess: false,
        error: "An unexpected error occurred. Please try again.",
        isLoading: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> phoneVerification(String email) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);

    try {
      final phoneVerificationData = {
        "method": "phoneActivation",
        "email": email,
      };

      final response = await apiService.post(
        ApiEndpoints.resendOTP,
        data: phoneVerificationData,
      );

      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(isPhoneSuccess: true);
      }
    } catch (e) {
      state = state.copyWith(
        isPhoneSuccess: false,
        error: "An unexpected error occurred. Please try again.",
        isLoading: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void resetState() {
    state = VerifyCodeState.initial();
  }
}

final verifyCodeProvider =
    StateNotifierProvider.autoDispose <VerifyCodeNotifier, VerifyCodeState>(
  (ref) => VerifyCodeNotifier(ref),
);
