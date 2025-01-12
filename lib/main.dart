import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/routes/app_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/ThemeController.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        if (!Get.isRegistered<ThemeController>()) {
          Get.put(ThemeController());
        }
        final themeController = Get.find<ThemeController>();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeController.theme,
          initialRoute: RouterPath.initialScreen,
          getPages: AppRouter.AppPages,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
        );
      },
    );
  }
}
