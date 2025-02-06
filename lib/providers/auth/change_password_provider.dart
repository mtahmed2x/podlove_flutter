import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class ChangePasswordState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  ChangePasswordState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory ChangePasswordState.initial() {
    return ChangePasswordState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  ChangePasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final Ref ref;

  ChangePasswordNotifier(this.ref) : super(ChangePasswordState.initial());

  Future<void> changePassword(
      String password, String newPassword, String confirmPassword) async {
    final changePasswordData = {
      "password": password,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
    state = state.copyWith(isLoading: true);
    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.post(
        ApiEndpoints.changePassword,
        data: changePasswordData,
      );
      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(
          isSuccess: true,
          isLoading: false,
        );
        logger.i(state.isLoading);
        logger.i(state.isSuccess);
      } else if (response.statusCode == StatusCode.UNAUTHORIZED) {
        state = state.copyWith(
          isSuccess: false,
          error:
              "Your current password is incorrect. Please check and try again.",
          isLoading: false,
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
}

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
        (ref) => ChangePasswordNotifier(ref));
