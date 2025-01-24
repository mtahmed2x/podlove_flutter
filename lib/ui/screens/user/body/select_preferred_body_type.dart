import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';

class SelectPreferredBodyType extends StatelessWidget {
  const SelectPreferredBodyType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Preferred Body Type"),
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
                      Text.rich(
                        TextSpan(
                          text:
                              "Do you have a preferred body type for potential matches?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  " (Select all that apply or choose No Preference)",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      label: "No Preference",
                      labelFontSize: 18,
                      labelFontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    text: "Note:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " While preferences are personal, we encourage an open mind to foster deeper connections and discover meaningful relationships.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectEthnicityPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
