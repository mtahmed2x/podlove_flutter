import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class SelectBodyType extends StatelessWidget {
  const SelectBodyType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Body Type"),
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
                        text: "How would you describe your body type?",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: "Choose the option that best represents you",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
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
                      text: "Please select one",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Athletic",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Curvy",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Slim",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Average",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Plus-size",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "Muscular",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreferredBodyTypesPage(),
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
