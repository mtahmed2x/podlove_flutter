import 'package:flutter/material.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_round_button.dart';

class Attention extends StatelessWidget {
  const Attention({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Attention"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 44.h), // Added responsive bottom padding
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h), // Responsive spacing
                SizedBox(
                  width: 120.w, // Responsive image width
                  child: Image.asset(
                    "assets/images/attention.png",
                    width: 120.w, // Responsive width
                    height: 120.h, // Responsive height
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30.h), // Responsive spacing
                Text(
                  "Attention",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp, // Responsive font size
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                ),
                SizedBox(height: 30.h), // Responsive spacing
                Expanded(
                  child: Text(
                    "Thank you for your interest in PodLove. Based on your responses, it seems our app may not be the right fit for you at this time. We appreciate you exploring our platform and wish you the best in finding the connections you're looking for. Feel free to check back with us in the future!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp, // Responsive font size
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Responsive spacing
                CustomRoundButton(
                  text: "Continue",
                  backgroundColor: const Color.fromARGB(255, 39, 87, 166),
                  onPressed: () => Get.toNamed(RouterPath.signUp),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
