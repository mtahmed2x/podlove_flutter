import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import 'package:podlove_flutter/providers/auth/verify_code_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class VerifyCode extends ConsumerWidget {
  final String status;
  final String title;
  final String? email;
  final String? phoneNumber;
  final String instructionText;

  const VerifyCode({
    super.key,
    required this.status,
    required this.title,
    required this.email,
    required this.phoneNumber,
    required this.instructionText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyCodeState = ref.watch(verifyCodeProvider);
    final verifyCodeNotifier = ref.read(verifyCodeProvider.notifier);

    ref.listen<VerifyCodeState>(
      verifyCodeProvider,
      (previous, current) {
        if (current.isSuccess == true) {
          GoRouter.of(context).go(RouterPath.locationAccess);
        }
      },
    );

    final contact =
        status == AppStrings.phoneActivationVerify ? phoneNumber : email;

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
          color: AppColors.accent,
          width: 0.8.w,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.accent,
          width: 1.0.w,
        ),
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        AppStrings.podLoveLogoPath,
                        width: 203.w,
                        height: 43.h,
                      ),
                      SizedBox(height: 25.h),
                      CustomText(
                        text: AppStrings.enterCode,
                        color: AppColors.primaryText,
                        fontSize: 22.h,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 20.h),
                      CustomText(
                        text: (instructionText + contact!),
                        color: AppColors.primaryText,
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
                  controller: verifyCodeNotifier.otpController,
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
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomRoundButton(
                  text: verifyCodeState.isLoading
                      ? AppStrings.verifyingCode
                      : AppStrings.verifyCode,
                  onPressed: verifyCodeState.isLoading
                      ? null
                      : () {
                          final otp = verifyCodeNotifier.otpController.text;
                          if (otp.length == 6) {
                            verifyCodeNotifier.verifyCode(
                              status,
                              email!,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppStrings.invalidOtpError),
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
