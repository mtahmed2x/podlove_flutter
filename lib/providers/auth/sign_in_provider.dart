import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/Response/sign_in_response_model.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  SignInState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory SignInState.initial() {
    return SignInState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  SignInState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? error,
    );
  }
}

class SignInNotifier extends StateNotifier<SignInState> {
  final ApiServices apiService;

  SignInNotifier(this.apiService) : super(SignInState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final signInData = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        ApiEndpoints.signIn,
        data: signInData,
      );
      logger.i(response);
      final SignInResponseModel signInResponse =
          SignInResponseModel.fromJson(response);

      if (signInResponse.success == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', signInResponse.data!.accessToken);
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return SignInNotifier(apiService);
  },
);
