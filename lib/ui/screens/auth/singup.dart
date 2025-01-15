import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/colors.dart';
import 'package:podlove_flutter/constants/strings_en.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/auth/sign_up_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.signUp),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w)
                    .copyWith(top: 40.h, bottom: 44.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 203.w,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/podLove.png",
                              width: 203.w,
                              height: 43.h,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 30.h),
                            CustomText(
                              text: AppStrings.welcomeBack,
                              color: const Color.fromARGB(255, 51, 51, 51),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                    ),
                    // Input Fields
                    CustomTextField(
                      fieldType: TextFieldType.text,
                      label: "Full Name",
                      hint: "Enter your full name here",
                      controller: controller.fullNameController,
                    ),
                    CustomTextField(
                      fieldType: TextFieldType.email,
                      label: "Email",
                      hint: "Enter your email",
                      controller: controller.emailController,
                    ),
                    CustomTextField(
                      fieldType: TextFieldType.text,
                      label: "Phone Number",
                      hint: "Enter your phone number",
                      controller: controller.phoneNumberController,
                    ),
                    CustomTextField(
                      fieldType: TextFieldType.password,
                      label: "Password",
                      hint: "Enter your password",
                      controller: controller.passwordController,
                    ),
                    CustomTextField(
                      fieldType: TextFieldType.password,
                      label: "Confirm Password",
                      hint: "Confirm your password",
                      controller: controller.confirmPasswordController,
                    ),
                    SizedBox(height: 30.h),
                    Obx(() => CustomRoundButton(
                      text: controller.isLoading.value
                          ? "Signing Up..."
                          : "Sign up",
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.signUp(),
                    )),
                    SizedBox(height: 15.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      color: const Color.fromARGB(255, 248, 248, 248),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Already have an account? ",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(RouterPath.signIn),
                              child: CustomText(
                                text: " Sign in",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: customOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
