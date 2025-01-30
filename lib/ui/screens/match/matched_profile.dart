import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class MatchedProfile extends StatelessWidget {
  final int index;

  const MatchedProfile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Match $index Bio"),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/flower.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      AppWidgets.podLoveLogo,
                      const SizedBox(height: 20),
                      Text(
                        "Match $index Bio",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: "",
                    maxLines: 5,
                    hint:
                    "I’m 40 years old, a proud parent of two and a grandparent of one. I teach 8th grade and have a passion for reading—this year alone, I finished 200 books!",
                  ),
                  const SizedBox(height: 30),
                  CustomText(
                    text: "Interests:",
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 20),
                  InterestGrid(
                    interests: [
                      'Photography',
                      'Travelling',
                      'Art & Crafts',
                      'Cooking',

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterestGrid extends StatelessWidget {
  final List<String> interests;

  const InterestGrid({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: interests.map((interest) => InterestButton(label: interest)).toList(),
    );
  }
}

class InterestButton extends StatelessWidget {
  final String label;

  const InterestButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.accent,
        ),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}