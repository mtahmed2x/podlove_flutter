import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

class ForgotPasswordState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;
  final String? email;

  ForgotPasswordState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
    this.email,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      isLoading: false,
      isSuccess: null,
      error: null,
      email: null,
    );
  }

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? email,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      email: email ?? this.email,
    );
  }
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final Ref ref;

  ForgotPasswordNotifier(this.ref) : super(ForgotPasswordState.initial());

  Future<void> forgotPassword(String email) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);
    final forgotPasswordData = {
      "email": email,
    };
    try {
      final response = await apiService.post(
        ApiEndpoints.recovery,
        data: forgotPasswordData,
      );

      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(
          isSuccess: true,
          email: forgotPasswordData["email"],
        );
      } else if (response.statusCode == StatusCode.NOT_FOUND) {
        state = state.copyWith(
          isSuccess: false,
          error: response.data["message"],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isSuccess: false,
        error: "An unexpected error occurred. Please try again.",
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
        (ref) => ForgotPasswordNotifier(ref));
