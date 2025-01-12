import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/services/api_service.dart'; // Path to your ApiService
import 'package:podlove_flutter/models/sign_up_response.dart';

import '../../routes/route_path.dart'; // Path to your SignUpResponse model

class SignUpController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

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

    try {
      final response = await _apiService.post<SignUpResponse>(
        "/auth/register",
        data: {
          "fullName": fullNameController.text,
          "email": emailController.text,
          "phoneNumber": phoneNumberController.text,
          "password": passwordController.text,
        },
        fromJson: (json) => SignUpResponse.fromJson(json),
      );

      if (response.success) {
        Get.snackbar("Success", response.message);
        Get.toNamed(RouterPath.signIn); // Navigate to Sign In page
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
