import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';

class Expectation extends StatelessWidget {
  const Expectation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.expect, isLeading: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                SizedBox(
                  width: 203.w,
                  child: AppWidgets.podLoveLogo,
                ),
                SizedBox(height: 30.h),
                Text(
                  "We Don't Match Profiles; We Match Souls",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  AppStrings.expect,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 241, 157, 118),
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  children: const [
                    _BulletItem(
                      title: "Initial Onboarding",
                      description: "Values Discovery",
                      imagePath: "assets/images/tick-image.png",
                    ),
                    _BulletItem(
                      title: "Matching Process",
                      description: "The Blind Connection",
                      imagePath: "assets/images/tick-image.png",
                    ),
                    _BulletItem(
                      title: "Matching Based On",
                      description:
                          "Value alignment\n • Compatibility scores\n • Shared life stage experiences\n • Communication style synergy",
                      imagePath: "assets/images/tick-image.png",
                    ),
                    _BulletItem(
                      title: "Podcast Interaction",
                      description:
                          "You meet your matches face to face during your podcast episode",
                      imagePath: "assets/images/tick-image.png",
                    ),
                    _BulletItem(
                      title: "Make date selection",
                      description: "During podcast",
                      imagePath: "assets/images/tick-image.png",
                    ),
                    _BulletItem(
                      title: "Return for post",
                      description: "Date podcast episode",
                      imagePath: "assets/images/tick-image.png",
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                CustomRoundButton(
                  text: AppStrings.next,
                  onPressed: () => context.push(RouterPath.termsOfUse),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const _BulletItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      // Responsive vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 24.w, // Responsive width for the image
            height: 24.h, // Responsive height for the image
          ),
          SizedBox(width: 10.w), // Responsive spacing
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: TextStyle(
                      fontSize: 18.sp, // Responsive font size
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: TextStyle(
                      fontSize: 18.sp, // Responsive font size
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
