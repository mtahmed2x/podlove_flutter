import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/auth/sign_up_provider.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/show_message_dialog.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ref.read(signUpProvider.notifier).resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);


    ref.listen<SignUpState>(
      signUpProvider,
          (previous, current) {
        if (current.isSuccess == true  && current.isLoading == false) {
          context.push(
            RouterPath.verifyCode,
            extra: {
              "method": Method.emailActivation,
              "email": current.email,
            },
          );
        } else if (current.isSuccess == false && current.isLoading == false) {
          if (current.isVerified == true) {
            showMessageDialog(
              context,
              "Alert",
              current.error.toString(),
                  () => context.push(RouterPath.signIn),
              buttonText: "Sign in",
            );
          } else if (current.isVerified == false) {
            showMessageDialog(
              context,
              "Alert",
              current.error.toString(),
                  () => context.push(
                RouterPath.verifyCode,
                extra: {
                  "method": Method.emailActivation,
                  "email": current.email,
                },
              ),
              buttonText: "Verify",
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: SizedBox(
                  width: 400.w,
                  child: AwesomeSnackbarContent(
                    title: "Error",
                    message: current.error!,
                    contentType: ContentType.failure,
                  ),
                ),
              ),
            );
          }
        }
      },
    );
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.signUp, isLeading: true),
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
                  Center(
                    child: SizedBox(
                      width: 203.w,
                      child: Column(
                        children: [
                          AppWidgets.podLoveLogo,
                          SizedBox(height: 40.h),
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
                    controller: nameController,
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
                    controller: emailController,
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
                    controller: phoneController,
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
                    controller: passwordController,
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
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.confirmPasswordError;
                      }
                      if (value != passwordController.text) {
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
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await signUpNotifier.signUp(
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                passwordController.text,
                              );
                            }
                          },
                  ),
                  SizedBox(height: 20.h),
                  // Sign In Link
                  Center(
                    child: GestureDetector(
                      onTap: () => context.push(RouterPath.signIn),
                      child: CustomText(
                        text: AppStrings.signInPrompt,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
