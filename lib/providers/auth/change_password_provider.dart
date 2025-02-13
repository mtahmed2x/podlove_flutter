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
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);
    final changePasswordData = {
      "password": password,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
    try {
      final response = await apiService.post(
        ApiEndpoints.changePassword,
        data: changePasswordData,
      );
      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(
          isSuccess: true,
          isLoading: false,
        );
      } else if (response.statusCode == StatusCode.UNAUTHORIZED) {
        state = state.copyWith(
          isSuccess: false,
          error:
              "Your current password is incorrect. Please check and try again.",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isSuccess: false,
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
        (ref) => ChangePasswordNotifier(ref));
