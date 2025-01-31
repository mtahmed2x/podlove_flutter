import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
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

    ref.listen(signInProvider, (prev, current) {
      if (current.isSuccess == true) {
        context.go(RouterPath.home);
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.welcome),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
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
                        AppWidgets.podLoveLogo,
                        SizedBox(height: 25.h),
                        CustomText(
                          text: AppStrings.welcomeBack,
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
                    label: AppStrings.email,
                    hint: AppStrings.emailHint,
                    controller: signInNotifier.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterEmailError;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: AppStrings.password,
                    hint: AppStrings.passwordHint,
                    controller: signInNotifier.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterPasswordError;
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      CustomCheckbox(
                        initialValue: true,
                        color: customOrange,
                        label: AppStrings.rememberMe,
                        onChanged: (value) {},
                        labelColor: const Color.fromARGB(255, 51, 51, 51),
                        labelFontSize: 14.sp,
                        labelFontWeight: FontWeight.w400,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => context.push(RouterPath.forgotPassword),
                        child: CustomText(
                          text: AppStrings.forgotPassword,
                          color: const Color.fromARGB(255, 43, 79, 111),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomRoundButton(
                    text: signInState.isLoading
                        ? AppStrings.signingIn
                        : AppStrings.signIn,
                    onPressed: signInState.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              signInNotifier.signIn();
                            }
                          },
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: CustomText(
                      text: AppStrings.orText,
                      color: const Color.fromARGB(255, 51, 51, 51),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SocialMediaButton(
                    path: AppStrings.googleLogoPath,
                    text: AppStrings.signInWithGoogle,
                  ),
                  SizedBox(height: 15.h),
                  SocialMediaButton(
                    path: AppStrings.appleLogoPath,
                    text: AppStrings.signInWithApple,
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
                            text: AppStrings.noAccountPrompt,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: () => context.push(RouterPath.signUp),
                            child: CustomText(
                              text: AppStrings.signUpLink,
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
