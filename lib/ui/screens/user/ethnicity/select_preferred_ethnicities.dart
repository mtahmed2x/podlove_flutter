import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPreferredEthnicities extends StatelessWidget {
  const SelectPreferredEthnicities({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: CustomAppBar(title: "Cultural & Ethnic Background"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        text:
                            "At PodLove, we believe love can flourish across all backgrounds. Are there any cultural or ethnic preferences that are important for you in a partner?",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 18.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Please select at least one",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "African American/Black",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Asian",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Caucasian/White",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Hispanic/Latino",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Middle Eastern",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Native American",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Pacific Islander",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Other",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {},
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
