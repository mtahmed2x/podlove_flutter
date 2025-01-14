import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? imageUrl;
  final String? secondImageUrl;
  final VoidCallback? onImageTap;
  final VoidCallback? onSecondImageTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.imageUrl,
    this.secondImageUrl,
    this.onImageTap,
    this.onSecondImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title:
          CustomText(text: title, fontWeight: FontWeight.w500, fontSize: 20.sp),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: const Color.fromARGB(255, 255, 161, 117),
          size: 24.sp,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        if (imageUrl != null)
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: onImageTap,
              child: Image.asset(
                imageUrl!,
                width: 24.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (secondImageUrl != null)
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: onSecondImageTap,
              child: Image.asset(
                secondImageUrl!,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
