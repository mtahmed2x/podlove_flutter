import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/providers/auth/sign_up_provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings_en.dart';
import '../../../routes/route_path.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    ref.listen<SignUpState>(signUpProvider, (previous, current) {
      if(current.isSuccess == true) {
        GoRouter.of(context).go(
          RouterPath.verifyCode,
          extra: {
            "state": "PhoneVerifyActivation",
            "title": "Verify Phone Number",
            "instructionText": "Please enter the six digit code we sent you to your number",
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
                // Form Fields
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Full Name",
                  hint: "Enter your full name here",
                  controller: signUpNotifier.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Please enter your full name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.email,
                  label: "Email",
                  hint: "Enter your email",
                  controller: signUpNotifier.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Please enter your email';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Phone Number",
                  hint: "Enter your phone number",
                  controller: signUpNotifier.phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Please enter your phone number';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "Password",
                  hint: "Enter your password",
                  controller: signUpNotifier.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Please enter your password';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "Confirm Password",
                  hint: "Confirm your password",
                  controller: signUpNotifier.confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Please confirm your password';
                    }
                    if (value != signUpNotifier.passwordController.text) {
                      return '* Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: signUpState.isLoading ? "Signing Up..." : "Sign up",
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
                      text: "Already have an account? Sign in",
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
