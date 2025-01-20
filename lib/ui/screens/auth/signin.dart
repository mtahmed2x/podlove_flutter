import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/colors.dart';
import 'package:podlove_flutter/constants/strings_en.dart';
import 'package:podlove_flutter/providers/auth/sign_in_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/social_media_button.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInProvider);
    final signInNotifier = ref.read(signInProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.welcome),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  // Header
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
                          text: "Welcome Back!",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 51, 51, 51),
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                  CustomTextField(
                    fieldType: TextFieldType.email,
                    label: "Email",
                    hint: "Enter your user email here",
                    controller: signInNotifier.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Please enter your email';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: "Password",
                    hint: "Enter your password",
                    controller: signInNotifier.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      CustomCheckbox(
                        initialValue: true,
                        color: customOrange,
                        label: 'Remember Me',
                        onChanged: (value) {},
                        labelColor: const Color.fromARGB(255, 51, 51, 51),
                        labelFontSize: 14.sp,
                        labelFontWeight: FontWeight.w400,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () =>
                            GoRouter.of(context).go(RouterPath.forgotPassword),
                        child: CustomText(
                          text: "Forgot Password?",
                          color: const Color.fromARGB(255, 43, 79, 111),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomRoundButton(
                    text: signInState.isLoading ? "Signing in ..." : "Sign in",
                    onPressed: signInState.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              signInNotifier.signIn();
                            }
                          },
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: CustomText(
                      text: "Or",
                      color: const Color.fromARGB(255, 51, 51, 51),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SocialMediaButton(
                    path: "assets/images/google.png",
                    text: "Sign in with Google",
                  ),
                  SizedBox(height: 15.h),
                  SocialMediaButton(
                    path: "assets/images/apple.png",
                    text: "Sign in with Apple",
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    color: const Color.fromARGB(255, 248, 248, 248),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don't have an account? ",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: () =>
                                GoRouter.of(context).go(RouterPath.signUp),
                            child: CustomText(
                              text: " Sign up",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: customOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
