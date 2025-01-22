import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class LocationAccess extends StatelessWidget {
  const LocationAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.locationAccessTitle),
      backgroundColor: AppColors.backgroundAlt,
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
                      // Logo
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 25.h),
                      Image.asset(
                        AppStrings.locationImagePath,
                        width: 170.w,
                        height: 130.h,
                      ),
                      SizedBox(height: 40.h),
                      CustomText(
                        text: AppStrings.enableLocationHeader,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: AppStrings.enableLocationDescription,
                        color: AppColors.primaryText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30.h),
                      CustomRoundButton(
                        text: AppStrings.allowLocationAccessButton,
                        onPressed: () {},
                      ),
                      SizedBox(height: 15.h),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: CustomText(
                            text: AppStrings.enterLocationManuallyLink,
                            style: TextStyle(
                              color:
                                  AppColors.accent, // Custom color for the text
                              fontSize: 16.sp,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  AppColors.accent, // Underline color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
