import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_exceptions.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;
  final bool? isProfileComplete;
  final bool? isVerified;

  SignInState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
    this.isProfileComplete,
    this.isVerified,
  });

  factory SignInState.initial() {
    return SignInState(
      isLoading: false,
      isSuccess: null,
      error: null,
      isProfileComplete: null,
      isVerified: null,
    );
  }

  SignInState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    bool? isProfileComplete,
    bool? isVerified

  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

class SignInNotifier extends StateNotifier<SignInState> {
  final Ref ref;

  SignInNotifier(this.ref) : super(SignInState.initial());

  Future<void> signIn(String email, String password) async {
    final apiService = ref.read(apiServiceProvider);
    logger.i(email);
    logger.i(password);
    final signInData = {
      "email": email,
      "password": password,
    };
    state = state.copyWith(isLoading: true);
    try {
      final response = await apiService.post(
        ApiEndpoints.signIn,
        data: signInData,
      );
      if (response.statusCode == StatusCode.OK) {
        String accessToken = response.data["data"]["accessToken"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);

        final isProfileComplete = prefs.getBool("isProfileComplete");

        if(isProfileComplete!) {
          state = state.copyWith(isSuccess: true, isProfileComplete: true);
        } else {
          state = state.copyWith(isSuccess: true, isProfileComplete: false);
        }
        state = state.copyWith(isSuccess: true);
      }
      else if(response.statusCode == StatusCode.NOT_FOUND) {
        logger.i(response.data["message"]);
      }
      else if(response.statusCode == StatusCode.UNAUTHORIZED) {
        state = state.copyWith(isSuccess: true, isVerified: false);
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

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) {
    return SignInNotifier(ref);
  },
);
