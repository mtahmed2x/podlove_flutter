import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/constants/app_themes.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/routes/app_router.dart';
import 'package:podlove_flutter/utils/logger.dart';

final apiServiceProvider = Provider<ApiServices>((ref) {
  final apiService = ApiServices.instance;
  apiService.init(baseUrl: ApiEndpoints.baseUrl);
  return apiService;
});
final routerProvider = Provider<GoRouter>((ref) => AppRouter.appRouter);
final themeProvider = Provider<ThemeData>((ref) => AppThemes.themeData);
final loggerProvider = Provider<Logger>((ref) => logger);
