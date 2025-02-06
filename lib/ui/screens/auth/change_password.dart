import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/auth/change_password_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/show_message_dialog.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/utils/logger.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordState = ref.watch(changePasswordProvider);
    final changePasswordNotifier = ref.read(changePasswordProvider.notifier);

    ref.listen<ChangePasswordState>(changePasswordProvider,
        (previous, current) {
      if (current.isSuccess == true && current.isLoading == false) {
        showMessageDialog(
          context,
          AppStrings.success,
          AppStrings.passwordChangeSuccessMessage,
          () => context.push(RouterPath.settings),
        );
      } else if (current.isSuccess != true &&
          current.error != null &&
          current.isLoading == false) {
        logger.i(current.error!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(current.error!),
          ),
        );
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.changePassword, isLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  CustomText(
                    text: AppStrings.setNewPassword,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: AppStrings.currentPassword,
                    hint: AppStrings.enterCurrentPassword,
                    controller: currentPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterPasswordError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: AppStrings.newPassword,
                    hint: AppStrings.enterNewPassword,
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterPasswordError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: AppStrings.retypePassword,
                    hint: AppStrings.retypeNewPassword,
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.confirmPasswordError;
                      }
                      if (value != newPasswordController.text) {
                        return AppStrings.passwordMismatchError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomRoundButton(
                    text: changePasswordState.isLoading
                        ? AppStrings.changingPassword
                        : AppStrings.changePasswordButton,
                    onPressed: changePasswordState.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              changePasswordNotifier.changePassword(
                                currentPasswordController.text,
                                newPasswordController.text,
                                confirmPasswordController.text,
                              );
                            }
                          },
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
