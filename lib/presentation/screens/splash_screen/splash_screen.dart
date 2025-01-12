import 'package:flutter/material.dart';
import 'package:podlove_flutter/presentation/screens/onboarding/approach.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Get.toNamed(RouterPath.approachToLove),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  "assets/images/podLove.png",
                  width: 301.w,
                  height: 64.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Deeper Connection",
                style: TextStyle(
                  fontSize: 24.sp, // Scale font size using ScreenUtil
                  color: Color.fromARGB(255, 255, 161, 117),
                ),
              ),
              SizedBox(height: 15.h), // Use ScreenUtil for spacing
              Text(
                "Begins Here",
                style: TextStyle(
                  fontSize: 20.sp, // Scale font size using ScreenUtil
                  color: Color.fromARGB(255, 39, 87, 166),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
