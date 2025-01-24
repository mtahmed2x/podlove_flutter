import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class AddBio extends StatelessWidget {
  const AddBio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Bio"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: [
                      AppWidgets.podLoveLogo,
                      const SizedBox(height: 25),
                      CustomText(
                        text: "Add Your Bio",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      CustomText(
                        text: "Please do not add your name",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                SizedBox(
                  child: CustomTextField(
                    fieldType: TextFieldType.text,
                    label: TextSpan(
                      text: "Write your bio ",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      children: [
                        TextSpan(
                          text: "( Max 200 words)",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 51, 51, 51),
                          ),
                        ),
                      ],
                    ),
                    hint: "Type here..",
                    maxLines: 5,
                  ),
                ),
                const SizedBox(height: 30),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadPhotoPage(),
                      ),
                    );
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
