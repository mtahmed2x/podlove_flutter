import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _navigate() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool("isFirstTime") ?? true;
    final accessToken = prefs.getString("accessToken");
    final isProfileComplete = prefs.getBool("isProfileComplete");

    logger.i(prefs.getBool('isProfileComplete'));

    if (!mounted) return;

    if (isFirstTime) {
      await prefs.setBool("isFirstTime", false);
      if (mounted) {
        context.push(RouterPath.approachToLove);
      }
    } else if (accessToken != null && isProfileComplete!) {
      if (mounted) {
        context.push(RouterPath.home);
      }
    } else {
      if (mounted) {
        context.push(RouterPath.signIn);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _navigate,
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
                  fontSize: 24.sp,
                  color: Color.fromARGB(255, 255, 161, 117),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "Begins Here",
                style: TextStyle(
                  fontSize: 20.sp,
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
