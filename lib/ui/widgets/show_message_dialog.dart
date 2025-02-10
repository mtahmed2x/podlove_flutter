import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showMessageDialog(BuildContext context, String title, String text, VoidCallback onPressed, {String buttonText = "OK"}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: Text(title)),
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          // Center the button
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.background,
              backgroundColor: AppColors.accent,
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.w),
            ),
            child: Text(buttonText),
          ),
        ),
      ],
    ),
  );
}