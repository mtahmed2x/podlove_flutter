import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
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
  final Ref ref;

  ResetPasswordNotifier(this.ref) : super(ResetPasswordState.initial());

  Future<void> resetPassword(
      String email, String password, String confirmPassword) async {
    final apiService = ref.read(apiServiceProvider);
    final resetPasswordData = {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        ApiEndpoints.resetPassword,
        data: resetPasswordData,
      );
      logger.i(response);
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
}

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
  (ref) {
    return ResetPasswordNotifier(ref);
  },
);
