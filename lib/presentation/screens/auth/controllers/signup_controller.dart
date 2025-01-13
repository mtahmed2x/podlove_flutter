import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    try {
      isLoading.value = true;
      final body = {
        "name": fullNameController.text,
        "email": emailController.text,
        "phoneNumber": phoneNumberController.text,
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text,
        "role": "USER",
      };


      final dio = Dio();
      dio.options.headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };


      final response = await dio.post(
        "http://10.0.60.41:7000/auth/register",
        data: body,
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response: ${response.data}');
        Get.snackbar("Success", "Sign-up successful");
      } else {
        Get.snackbar("Error", "Failed to sign up");
      }
    } on DioException catch (dioError) {
      print('DioError: ${dioError.response?.data ?? dioError.message}');
      Get.snackbar("Error", dioError.response?.data['message'] ?? "Sign-up failed");
    } catch (e) {
      print('Unexpected error: $e');
      Get.snackbar("Error", "An unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }

}
