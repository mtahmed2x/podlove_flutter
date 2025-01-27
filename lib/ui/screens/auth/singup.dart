import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/auth/sign_up_provider.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    ref.listen<SignUpState>(signUpProvider, (previous, current) {
      if (current.isSuccess == true) {
        GoRouter.of(context).go(
          RouterPath.verifyCode,
          extra: {
            "status": AppStrings.emailActivationVerify,
            "title": AppStrings.verifyEmail,
            "instructionText": AppStrings.verifyCodeInstruction,
            "phoneNumber": current.phoneNumber,
            "email": current.email,
          },
        );
      }
      if (current.isSuccess != true && current.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(current.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.signUp),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 203.w,
                    child: Column(
                      children: [
                        AppWidgets.podLoveLogo,
                        SizedBox(height: 30.h),
                        CustomText(
                          text: AppStrings.welcome,
                          color: const Color.fromARGB(255, 51, 51, 51),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
                // Form Fields
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: AppStrings.fullName,
                  hint: AppStrings.fullNameHint,
                  controller: signUpNotifier.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterFullNameError;
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.email,
                  label: AppStrings.email,
                  hint: AppStrings.emailHint,
                  controller: signUpNotifier.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterEmailError;
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: AppStrings.phoneNumber,
                  hint: AppStrings.phoneNumberHint,
                  controller: signUpNotifier.phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterPhoneNumberError;
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.password,
                  label: AppStrings.password,
                  hint: AppStrings.passwordHint,
                  controller: signUpNotifier.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterPasswordError;
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.password,
                  label: AppStrings.confirmPassword,
                  hint: AppStrings.confirmPasswordHint,
                  controller: signUpNotifier.confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.confirmPasswordError;
                    }
                    if (value != signUpNotifier.passwordController.text) {
                      return AppStrings.passwordMismatchError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: signUpState.isLoading
                      ? AppStrings.signingUp
                      : AppStrings.signUp,
                  onPressed: signUpState.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            signUpNotifier.signUp();
                          }
                        },
                ),
                SizedBox(height: 15.h),
                // Sign In Link
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouterPath.signIn),
                    child: CustomText(
                      text: AppStrings.signInPrompt,
                      color: customOrange,
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
