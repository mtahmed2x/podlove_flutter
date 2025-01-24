import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class SelectPreferredEthnicities extends StatelessWidget {
  const SelectPreferredEthnicities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Cultural & Ethnic Background"),
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
                        text:
                            "At PodLove, we believe love can flourish across all backgrounds. Are there any cultural or ethnic preferences that are important for you in a partner?",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 18,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Please select at least one",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "African American/Black ",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Asian",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Caucasian/White",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Hispanic/Latino",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Middle Eastern",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Native American",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Pacific Islander",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Other",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBioPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
