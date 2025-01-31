import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/api_endpoints.dart';
import 'data/services/api_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiServices.instance.init(baseUrl: ApiEndpoints.baseUrl);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', true);
  // if (!prefs.containsKey('isFirstTime')) {

  // }
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) {
        return const ProviderScope(child: MyApp());
      },
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.read(themeProvider);
    final appRouter = ref.read(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          routerConfig: appRouter,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
        );
      },
    );
  }
}
