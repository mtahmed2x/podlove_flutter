import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/presentation/widgets/custom_text_field.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset Password"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        "assets/images/podLove.png",
                        width: 250,
                        height: 50,
                      ),
                      const SizedBox(height: 25),
                      CustomText(
                          text: "Set a new password",
                          color: Color.fromARGB(255, 51, 51, 51),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),

                      const SizedBox(height: 15),
                      CustomText(
                        text:
                        "Create a new password. Ensure it differs from previous ones for security",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "Enter New Password",
                  hint: "Enter your new password",
                ),
                const CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "Confirm New Password",
                  hint: "Confirm your new password",
                ),
                const SizedBox(height: 15),
                CustomRoundButton(
                  text: "Reset Password",
                  onPressed: () => Get.toNamed(RouterPath.signIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
