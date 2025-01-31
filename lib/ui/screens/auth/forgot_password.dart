import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/auth/forgot_password_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});
  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);

    ref.listen<ForgotPasswordState>(
      forgotPasswordProvider,
      (previous, current) {
        if (current.isSuccess == true) {
          context.push(
            RouterPath.verifyCode,
            extra: {
              "status": AppStrings.emailRecoveryVerify,
              "title": AppStrings.verifyEmailTitle,
              "instructionText": AppStrings.verifyCodeInstruction,
              "email": current.email,
            },
          );
        }
      },
    );

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.forgotPassword),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 25.h),
                      CustomText(
                        text: AppStrings.forgotPassword,
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        text: AppStrings.forgotPasswordInstruction,
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: CustomTextField(
                    fieldType: TextFieldType.email,
                    label: AppStrings.email,
                    hint: AppStrings.emailHint,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterEmailError;
                      }
                      return null;
                    },
                    controller: forgotPasswordNotifier.emailController,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomRoundButton(
                  text: forgotPasswordState.isLoading
                      ? AppStrings.sendingCode
                      : AppStrings.sendCode,
                  onPressed: () => forgotPasswordState.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            forgotPasswordNotifier.forgotPassword();
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
