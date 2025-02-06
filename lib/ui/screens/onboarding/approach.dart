import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Approach extends StatelessWidget {
  const Approach({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.approach, isLeading: false),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w)
                .copyWith(top: 20.h, bottom: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                SizedBox(
                  width: 203.w,
                  child: AppWidgets.podLoveLogo,
                ),
                SizedBox(height: 40.h),
                Text(
                  AppStrings.approachTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: Text(
                    AppStrings.approachDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: AppStrings.next,
                  onPressed: () => context.push(RouterPath.expectationFromApp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
