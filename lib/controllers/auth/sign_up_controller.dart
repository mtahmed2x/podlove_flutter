import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/data/models/signup_response.dart';
import 'package:podlove_flutter/data/repositories/auth_repository.dart';
import '../../data/models/signup_request.dart';
import '../../routes/route_path.dart';

class SignUpController extends GetxController {
  final AuthRepository authRepository;
  SignUpController(this.authRepository);

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match!");
      return;
    }

    isLoading.value = true;
    const String endpoint = "auth/register";

    final signUpData = SignUpRequest(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      role: "USER",
      phoneNumber: phoneNumberController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    try {
      final SignUpResponse response = await authRepository.signUp(endpoint, signUpData);
      if (response.success) {
        Get.snackbar("Success", response.message);
        Get.toNamed(RouterPath.signIn);
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
