import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/global_error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiServices.instance.init(baseUrl: ApiEndpoints.baseUrl);

  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('isFirstTime')) {
    await prefs.setBool('isFirstTime', true);
  }
  if (!prefs.containsKey('isProfileComplete')) {
    await prefs.setBool('isProfileComplete', false);
  } else {
    logger.i(prefs.getBool('isProfileComplete'));
  }

  await Firebase.initializeApp();

  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) {
        return ProviderScope(
          observers: [GlobalErrorHandler(scaffoldMessengerKey)],
          child: MyApp(scaffoldMessengerKey: scaffoldMessengerKey),
        );
      },
    ),
  );
}

class MyApp extends ConsumerWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const MyApp({super.key, required this.scaffoldMessengerKey});

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
          scaffoldMessengerKey: scaffoldMessengerKey,
        );
      },
    );
  }
}
