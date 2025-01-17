import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/data/models/sign_up_model.dart';

class SignUpNotifier extends StateNotifier<SignUpModel> {
  SignUpNotifier() : super(SignUpModel()) {
    nameController.addListener(() => setFullName(nameController.text));
    emailController.addListener(() => setEmail(emailController.text));
    phoneController.addListener(() => setPhoneNumber(phoneController.text));
    passwordController.addListener(() => setPassword(passwordController.text));
    confirmPasswordController
        .addListener(() => setConfirmPassword(confirmPasswordController.text));
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void setFullName(String value) {
    state = state.copyWith(name: value);
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
  }

  Future<void> signUp() async {
    try {
      state = state.copyWith(isLoading: true);
      await Future.delayed(Duration(seconds: 2));
      print('User signed up successfully');
      print(state.name);
    } on Exception catch (e) {
      state = state.copyWith(
        signUpError: "An error occurred while signing up. Please try again.",
      );
      print('Error signing up user: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpModel>(
  (ref) => SignUpNotifier(),
);
