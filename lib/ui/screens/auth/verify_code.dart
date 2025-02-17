import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/auth/verify_code_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/show_message_dialog.dart';

class VerifyCode extends ConsumerStatefulWidget {
  final Method? method;
  final String? email;

  const VerifyCode({super.key, required this.method, required this.email});

  @override
  ConsumerState<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends ConsumerState<VerifyCode> {
  final otpController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.invalidate(verifyCodeProvider);
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyCodeState = ref.watch(verifyCodeProvider);
    final verifyCodeNotifier = ref.read(verifyCodeProvider.notifier);

    ref.listen<VerifyCodeState>(
      verifyCodeProvider,
      (previous, current) {
        if ((widget.method == Method.emailActivation ||
                widget.method == Method.phoneActivation) &&
            current.isVerificationSuccess == true &&
            current.isLoading == false) {
          context.push(RouterPath.locationAccess);
        } else if (widget.method == Method.emailRecovery &&
            current.isRecoverySuccess == true &&
            current.isLoading == false) {
          context.push(RouterPath.resetPass);
        } else if (widget.method == Method.emailActivation &&
            current.isPhoneUse == true &&
            current.isResendSuccess == true &&
            current.successMessage != null &&
            current.isLoading == false) {
          showMessageDialog(
            context,
            "Alert",
            current.successMessage!,
            () => context.push(
              RouterPath.verifyCode,
              extra: {
                "method": Method.phoneActivation,
                "email": widget.email,
              },
            ),
            buttonText: "Verify",
          );
        } else if (current.isResendSuccess == true &&
            current.isPhoneUse == false &&
            current.successMessage != null &&
            current.isLoading == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: SizedBox(
                width: 400.w,
                child: AwesomeSnackbarContent(
                  title: "Success",
                  message: current.successMessage!,
                  contentType: ContentType.success,
                ),
              ),
            ),
          );
        } else if ((current.isVerificationSuccess == false ||
                current.isResendSuccess == false ||
                current.isRecoverySuccess == false) &&
            current.isLoading == false &&
            current.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: SizedBox(
                width: 400.w,
                child: AwesomeSnackbarContent(
                  title: "Error",
                  message: current.error.toString(),
                  contentType: ContentType.failure,
                ),
              ),
            ),
          );
        }
      },
    );

    final defaultPinTheme = PinTheme(
      width: 47.w,
      height: 49.h,
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: AppColors.secondaryText,
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
      appBar: CustomAppBar(
        title: (widget.method == Method.emailActivation ||
                widget.method == Method.emailRecovery)
            ? "Verify Email"
            : "Verify Phone Number",
        isLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 40.h),
                      CustomText(
                        text: AppStrings.enterCode,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        text: (widget.method == Method.emailActivation ||
                                widget.method == Method.emailRecovery)
                            ? AppStrings.verifyEmailInstruction
                            : AppStrings.verifyPhoneInstruction,
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
                      onTap: verifyCodeState.isLoading
                          ? null
                          : () async {
                              await verifyCodeNotifier.resendOTP(
                                widget.method!,
                                widget.email!,
                                false,
                              );
                            },
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
                      : () async {
                          final otp = otpController.text;
                          if (otp.length == 6) {
                            if (widget.method == Method.emailActivation ||
                                widget.method == Method.phoneActivation) {
                              verifyCodeNotifier.activate(
                                widget.email!,
                                otp,
                              );
                            } else if (widget.method == Method.emailRecovery) {
                              verifyCodeNotifier.recoveryVerify(
                                widget.email!,
                                otp,
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: SizedBox(
                                  width: 400.w,
                                  child: AwesomeSnackbarContent(
                                    title: "Invalid OTP",
                                    message: AppStrings.invalidOtpError,
                                    contentType: ContentType.failure,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                ),
                SizedBox(height: 20.h),
                widget.method == Method.emailActivation
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: verifyCodeState.isLoading == true
                                ? null
                                : () async {
                                    await verifyCodeNotifier.resendOTP(
                                      Method.phoneActivation,
                                      widget.email!,
                                      true,
                                    );
                                  },
                            child: CustomText(
                              text: "Use Phone Instead",
                              color: AppColors.accent,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          verifyCodeState.isLoading == true
                              ? CustomText(
                                  text:
                                      "Sending verification code to the phone...",
                                )
                              : Container()
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
