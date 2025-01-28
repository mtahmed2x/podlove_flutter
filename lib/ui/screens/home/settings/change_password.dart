import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomText(
                    text: "Set your new password",
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                const SizedBox(height: 20),
                const CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "Current Password",
                  hint: "Enter current password",
                ),
                const CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "New Password",
                  hint: "Enter new password",
                ),
                const SizedBox(height: 10),
                const CustomTextField(
                  fieldType: TextFieldType.password,
                  label: "Retype Password",
                  hint: "Retype new password",
                ),
                const SizedBox(height: 20),
                CustomRoundButton(
                  text: "Change Password",
                  onPressed: () {},
                ),
              ],
            )),
      )),
    );
  }
}
