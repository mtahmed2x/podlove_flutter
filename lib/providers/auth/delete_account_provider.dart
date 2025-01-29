import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  DeleteAccountState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory DeleteAccountState.initial() {
    return DeleteAccountState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  DeleteAccountState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return DeleteAccountState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class DeleteAccountNotifier extends StateNotifier<DeleteAccountState> {
  final ApiServices apiService;

  DeleteAccountNotifier(this.apiService) : super(DeleteAccountState());

  Future<void> deleteAccount() async {
    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.delete(
        ApiEndpoints.deleteAccount,
      );
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('accessToken');
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
}

final deleteAccountProvider =
    StateNotifierProvider<DeleteAccountNotifier, DeleteAccountState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return DeleteAccountNotifier(apiService);
  },
);
