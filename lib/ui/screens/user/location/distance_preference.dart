import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/dynamic_range_slider.dart';

class DistancePreference extends StatelessWidget {
  const DistancePreference({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Distance Preferences"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        text: "Set Your Distance",
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      CustomText(
                        text: "Preferences",
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                DynamicRangeSlider(
                  min: 1,
                  max: 100,
                  initialValue: 65,
                  unit: "Miles",
                ),
                const SizedBox(height: 400),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectAgePage(),
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
