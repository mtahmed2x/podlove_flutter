import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSuccessDialog(BuildContext context, String title, String text, String path) {
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
            onPressed: () {
              context.push(path);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.background,
              backgroundColor: AppColors.accent,
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.w),
            ),
            child: const Text("OK"),
          ),
        ),
      ],
    ),
  );
}