import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/data/models/sign_up_response.dart';
import 'package:podlove_flutter/data/repositories/sign_up_repository.dart';
import '../../routes/route_path.dart';

class SignUpController extends GetxController {
  final SignUpRepository signUpRepository;
  SignUpController(this.signUpRepository);

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

    final Map<String, dynamic> data = {
      "name": fullNameController.text,
      "email": emailController.text,
      "role": "USER",
      "phoneNumber": phoneNumberController.text,
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text
    };

    try {
      final SignUpResponse response = await signUpRepository.signUp(endpoint, data);
      if (response.success) {
        Get.snackbar("Success", response.message);
        Get.toNamed(RouterPath.signIn);
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
