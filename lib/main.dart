import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('isFirstTime')) {
    await prefs.setBool('isFirstTime', true);
  }

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
