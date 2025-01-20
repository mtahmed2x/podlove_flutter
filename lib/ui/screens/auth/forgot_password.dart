import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Forgot Password"),
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
                          text: "Forgot Password?",
                          color: Color.fromARGB(255, 51, 51, 51),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),

                      const SizedBox(height: 15),
                      CustomText(
                        text:
                            "Enter your email and we will send you a verification code",
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
                  fieldType: TextFieldType.email,
                  label: "Email",
                  hint: "Enter your email",
                ),
                const SizedBox(height: 10),
                CustomRoundButton(
                  text: "Send Code",
                  onPressed: () => Get.toNamed(RouterPath.verifyCode),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
