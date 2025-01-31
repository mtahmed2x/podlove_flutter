import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchResults extends StatelessWidget {
  const MatchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Match Results"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/flower.png"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.white.withAlpha(128), BlendMode.modulate)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        Image.asset(
                          "assets/images/podLove.png",
                          width: 250.w,
                          height: 50.h,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Get Ready For Your Podcast Experiences!',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 60.h),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Center(
                child: Image.asset(
                  "assets/images/congrats.png",
                  width: 200.w,
                  height: 200.h,
                ),
              ),
              SizedBox(height: 40.h),
              CustomText(
                text: "Congratulations",
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 35, 104, 191),
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: "You have been matched",
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: "You will meet them during your\npodcast episode.",
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.h),
              CustomRoundButton(
                text: "Continue",
                onPressed: () => context.push(RouterPath.matches),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
