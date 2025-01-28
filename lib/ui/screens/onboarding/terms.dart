import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Terms of Use"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w)
                    .copyWith(top: 20.h, bottom: 44.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to our pod!",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "PodLove fosters deeper connections and intentional dating, creating a platform where genuine relationships blossom through innovative, podcast-style conversations. We envision a world where meaningful relationships are built on open communication, emotional compatibility, and mutual respect. By accessing or using our services, you agree to these Terms of Use, which outline your responsibilities and rights while engaging with PodLove.",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 16.h),
                    buildSection(
                      "Commitment to Safety and Respect",
                      "At PodLove, safety is the foundation of our platform. Every participant is expected to contribute to a culture of respect, kindness, and inclusivity. This commitment includes:",
                    ),
                    buildListItem("Active Respect",
                        "Treat all participants with dignity and kindness, regardless of background or beliefs."),
                    buildListItem("Safety Awareness",
                        "Uphold the importance of consent and personal boundaries in all interactions."),
                    buildListItem("Inclusivity",
                        "Embrace diversity and create a welcoming environment for all users."),
                    SizedBox(height: 16.h),
                    buildSection(
                      "User Responsibilities",
                      "By using PodLove, you agree to:",
                    ),
                    buildListItem("Honest Representation",
                        "Provide accurate information about yourself during registration and maintain a truthful profile."),
                    buildListItem("Genuine Intentions",
                        "Use the platform with the genuine desire to form meaningful, long-term connections."),
                    buildListItem("Consent and Communication",
                        "Respect the boundaries and preferences of others, ensuring that all interactions are consensual."),
                    buildListItem("Respect for Privacy",
                        "Keep personal and podcast information shared by others confidential."),
                    SizedBox(height: 16.h),
                    buildSection(
                      "Safety Measures",
                      "To create a secure and supportive environment, PodLove has implemented the following safety measures:",
                    ),
                    buildListItem("Comprehensive Vetting Process",
                        "Participants are vetted to ensure alignment with PodLove’s commitment to serious, respectful dating."),
                    buildListItem("AI Moderation",
                        "Our platform uses advanced technology to identify inappropriate or harmful behavior."),
                    buildListItem("Reporting System",
                        "Users can report any concerns or violations through the app’s support feature."),
                    buildListItem("Support Resources",
                        "PodLove provides resources and assistance to users experiencing issues with the platform or other participants."),
                    SizedBox(height: 16.h),
                    buildSection(
                      "Use of the Platform",
                      "PodLove’s services, including its app and podcast, are intended for users aged 35-50 who are seeking committed relationships. By using PodLove, you agree to:",
                    ),
                    buildListItem("Abide by laws",
                        "Abide by all applicable laws and regulations."),
                    buildListItem("Refrain from harm",
                        "Refrain from using the platform for any unlawful or harmful activities."),
                    buildListItem("Follow Instructions",
                        "Comply with all instructions provided by PodLove regarding participation in podcasts, matching, and dating."),
                    SizedBox(height: 16.h),
                    buildSection(
                      "Privacy and Data Usage",
                      "Your privacy is important to us. By using PodLove, you consent to our collection, storage, and use of your information as outlined in our Privacy Policy. PodLove does not sell or share your personal information with third parties without your explicit consent.",
                    ),
                    SizedBox(height: 16.h),
                    buildSection(
                      "Limitation of Liability",
                      "While PodLove strives to provide a safe and enjoyable experience, we cannot guarantee outcomes or the behavior of participants. Users are responsible for their interactions, and PodLove is not liable for any issues arising from connections made through the platform.",
                    ),
                    SizedBox(height: 16.h),
                    buildSection(
                      "Modifications to Terms",
                      "PodLove reserves the right to modify these Terms of Use at any time. Changes will be communicated to users, and continued use of the platform constitutes acceptance of the updated terms.",
                    ),
                    SizedBox(height: 16.h),
                    buildSection(
                      "Contact Us",
                      "If you have questions or concerns about these Terms of Use, please contact us at support@podlove.co.",
                    ),
                    SizedBox(height: 30.h),
                    CustomRoundButton(
                      text: "I Agree",
                      onPressed: () => GoRouter.of(context).go(RouterPath.connectionPathWay),
                    ),
                  ],
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildSection(String heading, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          description,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget buildListItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(fontSize: 16.sp),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
