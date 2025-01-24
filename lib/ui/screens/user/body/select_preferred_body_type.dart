import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPreferredBodyType extends StatelessWidget {
  const SelectPreferredBodyType({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: CustomAppBar(title: "Preferred Body Type"),
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
                      Text.rich(
                        TextSpan(
                          text:
                              "Do you have a preferred body type for potential matches?",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  " (Select all that apply or choose No Preference)",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCheckbox(
                      label: "Athletic",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Curvy",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Slim",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Average",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Plus-size",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Muscular",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "No Preference",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Text.rich(
                  TextSpan(
                    text: "Note:",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " While preferences are personal, we encourage an open mind to foster deeper connections and discover meaningful relationships.",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {},
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
