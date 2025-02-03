import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/auth/reset_password_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/show_success_dialog.dart';

class ResetPassword extends ConsumerStatefulWidget {
  final String? email;

  const ResetPassword({super.key, required this.email});

  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final resetPasswordState = ref.watch(resetPasswordProvider);
    final resetPasswordNotifier = ref.watch(resetPasswordProvider.notifier);

    ref.listen<ResetPasswordState>(
        resetPasswordProvider, (previous, current) {
          if(current.isSuccess == true) {
            showSuccessDialog(context, "Success", "Password Changed Successfully", RouterPath.signIn);
          }
    });

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.resetPasswordTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
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
                        text: AppStrings.setNewPasswordHeader,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        text: AppStrings.setNewPasswordDescription,
                        color: AppColors.primaryText,
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
                  child: Column(
                    children: [
                      CustomTextField(
                        fieldType: TextFieldType.password,
                        label: AppStrings.enterNewPasswordLabel,
                        hint: AppStrings.enterNewPasswordHint,
                        controller: passwordController,
                      ),
                      CustomTextField(
                        fieldType: TextFieldType.password,
                        label: AppStrings.confirmNewPasswordLabel,
                        hint: AppStrings.confirmNewPasswordHint,
                        controller: confirmPasswordController,
                      ),
                      SizedBox(height: 15.h),
                      CustomRoundButton(
                        text: resetPasswordState.isLoading
                            ? AppStrings.resettingPassword
                            : AppStrings.resetPassword,
                        onPressed: resetPasswordState.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  resetPasswordNotifier.resetPassword(
                                    widget.email!,
                                    passwordController.text,
                                    confirmPasswordController.text,
                                  );
                                }
                              },
                      ),
                    ],
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
