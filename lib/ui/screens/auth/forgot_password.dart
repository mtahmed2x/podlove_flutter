import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/forgot_password_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.invalidate(forgotPasswordProvider);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);

    ref.listen<ForgotPasswordState>(
      forgotPasswordProvider,
      (previous, current) {
        if (current.isSuccess == true && current.isLoading == false) {
          context.push(
            RouterPath.verifyCode,
            extra: {
              "method": Method.emailRecovery,
              "email": current.email,
            },
          );
        } else if (current.isSuccess == false &&
            current.error != null &&
            current.isLoading == false) {
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
                    controller: emailController,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: forgotPasswordState.isLoading
                      ? AppStrings.sendingCode
                      : AppStrings.sendCode,
                  onPressed: forgotPasswordState.isLoading ? null : () async {
                    logger.i(emailController.text);
                    if (_formKey.currentState!.validate()) {
                      await forgotPasswordNotifier
                          .forgotPassword(emailController.text);
                    } else {
                      logger.i("No Email");
                    }
                  },
                  // onPressed: () => forgotPasswordState.isLoading
                  //     ? null
                  //     : () async {
                  //
                  //         if (_formKey.currentState!.validate()) {
                  //           await forgotPasswordNotifier
                  //               .forgotPassword(emailController.text);
                  //         }
                  //       },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
