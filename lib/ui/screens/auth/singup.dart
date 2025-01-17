import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:podlove_flutter/providers/sign_up_provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings_en.dart';
import '../../../routes/route_path.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.signUp),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
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
              ),
              CustomTextField(
                fieldType: TextFieldType.email,
                label: "Email",
                hint: "Enter your email",
                controller: signUpNotifier.emailController,
              ),
              CustomTextField(
                fieldType: TextFieldType.text,
                label: "Phone Number",
                hint: "Enter your phone number",
                controller: signUpNotifier.phoneController,
              ),
              CustomTextField(
                fieldType: TextFieldType.password,
                label: "Password",
                hint: "Enter your password",
                controller: signUpNotifier.passwordController,
              ),
              CustomTextField(
                fieldType: TextFieldType.password,
                label: "Confirm Password",
                hint: "Confirm your password",
                controller: signUpNotifier.confirmPasswordController,
              ),
              SizedBox(height: 30.h),
              // Spacer to push the button down when content is short

              CustomRoundButton(
                text: signUpState.isLoading ? "Signing Up..." : "Sign up",
                onPressed: signUpState.isLoading
                    ? null
                    : () => signUpNotifier.signUp(),
              ),
              SizedBox(height: 15.h),
              // Sign In Link
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RouterPath.signIn),
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
    );
  }
}
