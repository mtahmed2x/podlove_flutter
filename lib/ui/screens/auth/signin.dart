import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/constants/colors.dart';
import 'package:podlove_flutter/constants/strings_en.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/social_media_button.dart';

class SignIn extends StatelessWidget {
  const SignIn ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.welcome),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                // Header
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
                        text: "Welcome Back!",
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),

                const CustomTextField(
                  fieldType: TextFieldType.email,
                  label: "User Name",
                  hint: "Enter your user name here",
                ),

                const CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "Password",
                  hint: "Enter your password",
                ),

                Row(
                  children: [
                    CustomCheckbox(
                      initialValue: true,
                      color: customOrange,
                      label: 'Remember Me',
                      onChanged: (value) {},
                      labelColor: Color.fromARGB(255, 51, 51, 51),
                      labelFontSize: 14,
                      labelFontWeight: FontWeight.w400,
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () => Get.toNamed(RouterPath.forgotPassword) ,
                        child: CustomText(
                          text: "Forgot Password?",
                          color: Color.fromARGB(255, 43, 79, 111),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                CustomRoundButton(
                  text: "Sign in",
                  onPressed: () => Get.toNamed(RouterPath.initialScreen),
                ),
                const SizedBox(height: 20),
                const Center(
                    child: CustomText(
                        text: "Or",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 20),
                SocialMediaButton(
                    path: "assets/images/google.png",
                    text: "Sign in with Google"),
                const SizedBox(height: 15),
                SocialMediaButton(
                    path: "assets/images/apple.png",
                    text: "Sign in with Apple"),

                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: const Color.fromARGB(255, 248, 248, 248),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Don't have an account? ",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouterPath.signUp),
                          child: CustomText(
                            text: " Sign up",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: customOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

