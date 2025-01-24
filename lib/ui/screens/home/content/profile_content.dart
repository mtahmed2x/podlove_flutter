import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        imageUrl: "assets/images/edit-icon.png",
        onImageTap: () {},
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      CircleAvatar(
                        radius: 48,
                        backgroundImage:
                            AssetImage("assets/images/profile-avatar.png"),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: "Robert Smith",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        text: "robertsmith34@gmail.com",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Bio:",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text:
                          "Passionate about photography and exploring new places. Family-oriented, career-driven, and ready to meet someone who shares my values. Bonus points if you love dogs!",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Phone Number:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: "567-123-4567",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Age:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: "42 years",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Gender:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: "Male",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Gender Preference:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: "Female",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Location:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: "Laguna Beach, CA",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
