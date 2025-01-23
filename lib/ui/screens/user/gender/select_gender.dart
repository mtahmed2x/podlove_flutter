import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_circle_group.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class SelectGender extends StatelessWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.selectGenderTitle),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                            text: AppStrings.genderQuestion,
                            color: AppColors.primaryText,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 40.h),
                          CustomCircleGroup(
                            labels: [
                              AppStrings.female,
                              AppStrings.male,
                              AppStrings.nonBinary,
                              AppStrings.transgender,
                              AppStrings.genderFluid,
                            ],
                            onCircleSelected: (index) {},
                          ),
                          SizedBox(height: 50.h),
                          CustomRoundButton(
                            text: AppStrings.continueButton,
                            onPressed: () {},
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
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
}
