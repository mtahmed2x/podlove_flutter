import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyCodeState {
  final bool isLoading;
  final bool? isVerificationSuccess;
  final bool? isRecoverySuccess;
  final bool? isResendSuccess;
  final bool? isPhoneUse;
  final String? successMessage;
  final String? error;

  VerifyCodeState({
    this.isLoading = false,
    this.isVerificationSuccess,
    this.isRecoverySuccess,
    this.isResendSuccess,
    this.isPhoneUse,
    this.successMessage,
    this.error,
  });

  factory VerifyCodeState.initial() {
    return VerifyCodeState(
      isLoading: false,
      isVerificationSuccess: null,
      isRecoverySuccess: null,
      isResendSuccess: null,
      isPhoneUse: null,
      successMessage: null,
      error: null,
    );
  }

  VerifyCodeState copyWith({
    bool? isLoading,
    bool? isVerificationSuccess,
    bool? isRecoverySuccess,
    bool? isResendSuccess,
    bool? isPhoneUse,
    String? successMessage,
    String? error,
  }) {
    return VerifyCodeState(
      isLoading: isLoading ?? this.isLoading,
      isVerificationSuccess:
          isVerificationSuccess ?? this.isVerificationSuccess,
      isRecoverySuccess: isRecoverySuccess ?? this.isRecoverySuccess,
      isResendSuccess: isResendSuccess ?? this.isResendSuccess,
      isPhoneUse: isPhoneUse ?? this.isPhoneUse,
      successMessage: successMessage ?? this.successMessage,
      error: error ?? this.error,
    );
  }
}

class VerifyCodeNotifier extends StateNotifier<VerifyCodeState> {
  final Ref ref;

  VerifyCodeNotifier(this.ref) : super(VerifyCodeState.initial());

  Future<void> activate(String email, String otp) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);
    final activationData = {
      "email": email,
      "verificationOTP": otp,
    };
    try {
      final response = await apiService.post(
        ApiEndpoints.activate,
        data: activationData,
      );
      if (response.statusCode == StatusCode.OK) {
        final accessToken = response.data["data"]["accessToken"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        ref
            .read(userProvider.notifier)
            .initialize(response.data["data"]["user"]);
        state = state.copyWith(isVerificationSuccess: true);
      } else if (response.statusCode == StatusCode.UNAUTHORIZED) {
        state = state.copyWith(
            isVerificationSuccess: false, error: response.data["message"]);
      }
    } catch (e) {
      state = state.copyWith(
        isVerificationSuccess: false,
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> recoveryVerify(String email, String otp) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);
    final recoveryVerifyData = {
      "email": email,
      "recoveryOTP": otp,
    };
    try {
      final response = await apiService.post(
        ApiEndpoints.recoveryVerify,
        data: recoveryVerifyData,
      );
      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(isRecoverySuccess: true);
      } else if (response.statusCode == StatusCode.UNAUTHORIZED) {
        state = state.copyWith(
            isRecoverySuccess: false, error: response.data["message"]);
      }
    } catch (e) {
      state = state.copyWith(isRecoverySuccess: false, error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resendOTP(Method method, String email, bool isPhoneUse) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);
    var successMessage = "";
    if (method == Method.emailActivation) {
      successMessage = AppStrings.emailVerificationSent;
    } else if (method == Method.phoneActivation) {
      successMessage = AppStrings.phoneVerificationSent;
    } else {
      successMessage = AppStrings.recoveryVerificationSent;
    }
    final resendOTPData = {
      "method": method.toString(),
      "email": email,
    };
    try {
      final response = await apiService.post(
        ApiEndpoints.resendOTP,
        data: resendOTPData,
      );
      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(
            isResendSuccess: true, successMessage: successMessage, isPhoneUse: isPhoneUse);
      } else if (response.statusCode == StatusCode.CONFLICT) {
        state = state.copyWith(
            isResendSuccess: false, error: response.data["message"]);
      }
    } catch (e) {
      state = state.copyWith(
        isResendSuccess: false,
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final verifyCodeProvider =
    StateNotifierProvider.autoDispose<VerifyCodeNotifier, VerifyCodeState>(
  (ref) => VerifyCodeNotifier(ref),
);
