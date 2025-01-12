import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:get/get.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/otp_input_field.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Verify Email"),
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
                        "Please enter the six digit code we sent you to your email",
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
                  onPressed: () => Get.toNamed(RouterPath.resetPass),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
