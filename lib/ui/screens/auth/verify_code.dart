import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/strings_en.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:podlove_flutter/constants/colors.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class VerifyCode extends StatelessWidget {
  final String state;
  final String title;
  final String? email;
  final String? phoneNumber;
  final String instructionText;

  const VerifyCode({
    super.key,
    required this.state,
    required this.title,
    required this.email,
    required this.phoneNumber,
    required this.instructionText,
  });

  @override
  Widget build(BuildContext context) {
    final contact = state == "PhoneVerifyActivation" ? phoneNumber : email;
    final TextEditingController otpController = TextEditingController();
    final defaultPinTheme = PinTheme(
      width: 47.w,
      height: 49.h,
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: customOrange,
          width: 0.8.w,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: customOrange,
          width: 1.0.w,
        ),
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(title: title),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        "assets/images/podLove.png",
                        width: 203.w,
                        height: 43.h,
                      ),
                      SizedBox(height: 25.h),
                      CustomText(
                        text: "Enter Code",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.h,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 20.h),
                      CustomText(
                        text: (instructionText + contact!),
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                Pinput(
                  length: 6,
                  controller: otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  showCursor: true,
                ),
                // Resend OTP Link
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h, right: 10.w),
                    child: GestureDetector(
                      onTap: () {},
                      child: CustomText(
                        text: AppStrings.resendOtp,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: customOrange,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomRoundButton(
                  text: "Verify Code",
                  onPressed: () {
                    final otp = otpController.text;
                    if (otp.length == 6) {

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter a valid 6-digit code"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
