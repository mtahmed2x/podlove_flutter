import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

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
  final ApiServices apiService;

  ChangePasswordNotifier(this.apiService) : super(ChangePasswordState());

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  Future<void> changePassword() async {
    final changePasswordData = {
      "password": currentPasswordController.text,
      "newPassword": newPasswordController.text,
      "confirmPassword": retypePasswordController.text,
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        ApiEndpoints.changePassword,
        data: changePasswordData,
      );
      if (response.statusCode == 200) {
        state = state.copyWith(
          isSuccess: true,
          isLoading: false,
        );
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
    currentPasswordController.dispose();
    newPasswordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }
}

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return ChangePasswordNotifier(apiService);
  },
);
