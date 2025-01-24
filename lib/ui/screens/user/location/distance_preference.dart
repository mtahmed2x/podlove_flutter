import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/dynamic_range_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DistancePreference extends StatelessWidget {
  const DistancePreference({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: CustomAppBar(title: "Distance Preferences"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 25.h),
                      CustomText(
                        text: "Set Your Distance",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      CustomText(
                        text: "Preferences",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                DynamicRangeSlider(
                  min: 1,
                  max: 100,
                  initialValue: 65,
                  unit: "Miles",
                ),
                SizedBox(height: 400.h),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
