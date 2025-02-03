import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/auth/change_password_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/show_success_dialog.dart';

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
      if (current.isSuccess == true) {
        showSuccessDialog(context, "Success", "Password Changed Successfully",
            RouterPath.settings);
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomText(
                      text: "Set your new password",
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  const SizedBox(height: 20),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: "Current Password",
                    hint: "Enter current password",
                    controller: currentPasswordController,
                  ),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: "New Password",
                    hint: "Enter new password",
                    controller: newPasswordController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: "Retype Password",
                    hint: "Retype new password",
                    controller: confirmPasswordController,
                  ),
                  SizedBox(height: 20),
                  CustomRoundButton(
                    text: changePasswordState.isLoading
                        ? "Changing..."
                        : "Change Password",
                    onPressed: changePasswordState.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              changePasswordNotifier.changePassword(
                                  currentPasswordController.text,
                                  newPasswordController.text,
                                  confirmPasswordController.text);
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
