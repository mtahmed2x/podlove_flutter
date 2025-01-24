import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectBodyType extends StatelessWidget {
  const SelectBodyType({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: CustomAppBar(title: "Body Type"),
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
                        text: "How would you describe your body type?",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 20.h),
                      CustomText(
                        text: "Choose the option that best represents you",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
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
                      text: "Please select one",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 15.h),
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
                  ],
                ),
                SizedBox(height: 60.h),
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
