import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_exceptions.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

class SignUpState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;
  final String? phoneNumber;
  final String? email;

  SignUpState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
    this.phoneNumber,
    this.email,
  });

  factory SignUpState.initial() {
    return SignUpState(
      isLoading: false,
      isSuccess: null,
      error: null,
      phoneNumber: null,
      email: null,
    );
  }

  SignUpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? phoneNumber,
    String? email,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      error: error ?? this.error,
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
        state = state.copyWith(
          isSuccess: true,
          phoneNumber: signUpData["phoneNumber"],
          email: signUpData["email"],
        );
      } else if (response.statusCode == StatusCode.BAD_REQUEST) {
        final errorMessage =
            response.data['data']?['message'] ?? "Signup failed.";
        state = state.copyWith(isSuccess: false, error: errorMessage);
      } else if (response.statusCode == StatusCode.CONFLICT) {
        final error = response.data['data']?['isVerified'] == true
            ? "Your account already exists. Please login."
            : "Your account already exists. Please verify.";
        state = state.copyWith(isSuccess: false, error: error);
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

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) {
    return SignUpNotifier(ref);
  },
);
