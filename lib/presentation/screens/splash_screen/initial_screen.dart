import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podlove_flutter/routes/route_path.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => Get.toNamed(RouterPath.splashScreen),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
