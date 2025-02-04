import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_exceptions.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;
  final String? email;
  final bool? isVerified;

  SignUpState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
    this.email,
    this.isVerified,
  });

  factory SignUpState.initial() {
    return SignUpState(
      isLoading: false,
      isSuccess: null,
      error: null,
      email: null,
      isVerified: null,
    );
  }

  SignUpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? phoneNumber,
    String? email,
    bool? isVerified,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      email: email ?? this.email,
      error: error ?? this.error,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpNotifier(this.ref) : super(SignUpState.initial());

  Future<void> signUp(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final apiService = ref.read(apiServiceProvider);

    final signUpData = {
      "name": name,
      "email": email,
      "phoneNumber": phone,
      "password": password,
      "confirmPassword": password,
    };

    state = state.copyWith(isLoading: true);

    try {
      final response =
          await apiService.post(ApiEndpoints.signUp, data: signUpData);

      if (response.statusCode == StatusCode.CREATED) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isProfileComplete', false);

        state = state.copyWith(
          isSuccess: true,
          email: signUpData["email"],
        );
      } else if (response.statusCode == StatusCode.BAD_REQUEST) {
        final errorMessage =
            response.data['data']?['message'] ?? "Signup failed.";
        state = state.copyWith(isSuccess: false, error: errorMessage);
      } else if (response.statusCode == StatusCode.CONFLICT) {
        final isVerified = response.data['data']?['isVerified'];
        final error = isVerified == true
            ? "Your account already exists. Please login."
            : "Your account already exists. Please verify.";
        state = state.copyWith(isSuccess: false, email: signUpData["email"], isVerified: isVerified, error: error);
      } else {
        state = state.copyWith(
            isSuccess: false, error: "Unexpected error occurred.");
      }
    } on ApiException catch (e) {
      state = state.copyWith(isSuccess: false, error: e.message);
    } catch (e) {
      state =
          state.copyWith(isSuccess: false, error: "An unknown error occurred.");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final signUpProvider = StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
  (ref) {
    return SignUpNotifier(ref);
  },
);
