import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/theme_controller.dart';

class CustomRoundButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const CustomRoundButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return SizedBox(
      width: double.infinity,
      height: 48.h, // Responsive height using ScreenUtil
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeController.colorScheme.secondary, // Use provided or theme color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r), // Responsive radius
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp, // Responsive font size
            fontWeight: FontWeight.w400,
            color: themeController.colorScheme.onSecondary, // Text color from theme
          ),
        ),
      ),
    );
  }
}
