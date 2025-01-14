import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/constants/colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/otp_input_field.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Verify Phone"),
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
                          text: "Enter Code",
                          color: Color.fromARGB(255, 51, 51, 51),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),

                      const SizedBox(height: 15),
                      CustomText(
                        text:
                        "Please enter the six digit code we sent you to your phone",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                OTPInputField(),
                const SizedBox(height: 30),
                CustomRoundButton(
                  text: "Verify Code",
                  onPressed: () => Get.toNamed(RouterPath.signIn),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(RouterPath.emailVerification),
                    child: CustomText(
                      text: 'Use Email Instead',
                      style: TextStyle(
                          color: customOrange, // Your custom color for the text
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: customOrange // Underline the text
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
