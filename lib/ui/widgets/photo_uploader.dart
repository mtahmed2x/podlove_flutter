import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';

class PhotoUploader extends StatelessWidget {
  final void Function()? onUpload;

  const PhotoUploader({super.key, this.onUpload});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpload,
      child: DottedBorder(
        color: AppColors.accent,
        strokeWidth: 2,
        dashPattern: [6, 2],
        borderType: BorderType.RRect,
        radius: Radius.circular(8.w),
        child: Container(
          height: 44.h,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/add_a_photo.png",
                height: 24.h,
                width: 24.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
