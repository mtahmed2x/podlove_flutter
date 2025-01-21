import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset Password"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        "assets/images/podLove.png",
                        width: 250.w,
                        height: 50.h,
                      ),
                      SizedBox(height: 25.h),
                      CustomText(
                        text: "Set a new password",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        text:
                            "Create a new password. Ensure it differs from previous ones for security",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
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
                SizedBox(height: 15.h),
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
