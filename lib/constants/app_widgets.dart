import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_strings.dart';

class AppWidgets {
  static Widget podLoveLogo = Image.asset(
    AppStrings.podLoveLogoPath,
    width: 203.w,
    height: 43.h,
    fit: BoxFit.cover,
  );
}
