import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/data/services/api_exceptions.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInState {
  final bool isLoading;
  final bool? isSuccess;
  final SignInErrorType? errorType;
  final String? error;
  final bool? isProfileComplete;

  final String? email;

  SignInState({
    this.isLoading = false,
    this.isSuccess,
    this.errorType,
    this.error,
    this.isProfileComplete,
    this.email,
  });

  factory SignInState.initial() {
    return SignInState(
      isLoading: false,
      isSuccess: null,
      errorType: null,
      error: null,
      isProfileComplete: null,
      email: null,
    );
  }

  SignInState copyWith({
    bool? isLoading,
    bool? isSuccess,
    SignInErrorType? errorType,
    String? error,
    bool? isProfileComplete,
    String? email,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorType: errorType ?? this.errorType,
      error: error ?? this.error,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      email: email ?? this.email,
    );
  }
}

class SignInNotifier extends StateNotifier<SignInState> {
  final Ref ref;

  SignInNotifier(this.ref) : super(SignInState.initial());

  Future<void> signIn(String email, String password) async {
    final apiService = ref.read(apiServiceProvider);
    final signInData = {
      "email": email,
      "password": password,
    };

    state = state.copyWith(email: email, isLoading: true);

    try {
      final response = await apiService.post(
        ApiEndpoints.signIn,
        data: signInData,
      );

      if (response.statusCode == StatusCode.OK) {
        String accessToken = response.data["data"]["accessToken"];
        final userJson = response.data["data"]["user"];
        ref.read(userProvider.notifier).initialize(userJson);
        final isProfileComplete =
            ref.watch(userProvider)?.user.isProfileComplete;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setBool('isProfileComplete', isProfileComplete!);

        if (isProfileComplete) {
          state = state.copyWith(isProfileComplete: true);
        } else {
          state = state.copyWith(isProfileComplete: false);
        }
        state = state.copyWith(isSuccess: true);
      } else if (response.statusCode == StatusCode.NOT_FOUND) {
        state = state.copyWith(
          isSuccess: false,
          errorType: SignInErrorType.notFound,
          error: "No account found with that email address.",
        );
        logger.i(state.errorType);
      } else if (response.statusCode == StatusCode.UNAUTHORIZED &&
          response.data["message"] == "Wrong password") {
        state = state.copyWith(
          isSuccess: false,
          errorType: SignInErrorType.wrongPassword,
          error: "The password you entered is incorrect. Please try again.",
        );
      } else if (response.statusCode == StatusCode.UNAUTHORIZED) {
        state = state.copyWith(
          isSuccess: false,
          errorType: SignInErrorType.notVerified,
          email: email,
          error:
              "Your account is not verified yet. Please check your email for the verification code.",
        );
      } else if (response.statusCode == StatusCode.FORBIDDEN) {
        state = state.copyWith(
          isSuccess: false,
          errorType: SignInErrorType.blocked,
          error:
              "Your account has been blocked. Please contact admin for assistance.",
        );
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

  Future<bool> resendOTP(String method, String email) async {
    final apiService = ref.read(apiServiceProvider);
    logger.i(method);
    final resendOTPData = {
      "method": method,
      "email": email,
    };
    final response = await apiService.post(
      ApiEndpoints.resendOTP,
      data: resendOTPData,
    );
    if (response.statusCode == StatusCode.OK) {
      return true;
    }
    return false;
  }

  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    final account = await googleSignIn.signIn();
    if (account != null) {
      logger.i(account.id);
      logger.i(account.displayName);
      logger.i(account.email);
      logger.i(account.photoUrl);

      final apiService = ref.read(apiServiceProvider);
      final signInWithGoogleData = {
        "googleId": account.id,
        "name": account.displayName,
        "email": account.email,
        "avatar": account.photoUrl
      };
      try {
        final response = await apiService.post(ApiEndpoints.signInWithGoogle, data: signInWithGoogleData);
        if (response.statusCode == StatusCode.OK) {
          String accessToken = response.data["data"]["accessToken"];
          final userJson = response.data["data"]["user"];
          ref.read(userProvider.notifier).initialize(userJson);
          final isProfileComplete =
              ref.watch(userProvider)?.user.isProfileComplete;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);
          await prefs.setBool('isProfileComplete', isProfileComplete!);
          await prefs.setBool('isGoogleLogin', true);

          logger.i(prefs.getString('accessToken'));

          if (isProfileComplete) {
            state = state.copyWith(isProfileComplete: true);
          } else {
            state = state.copyWith(isProfileComplete: false);
          }
          state = state.copyWith(isSuccess: true);
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

  void resetState() {
    state = SignInState.initial();
  }
}

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) {
    return SignInNotifier(ref);
  },
);
