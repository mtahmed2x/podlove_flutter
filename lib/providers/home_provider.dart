import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/home_model.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'global_providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/subscription_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class HomeNotifier extends StateNotifier<AsyncValue<HomeModel>> {
  final Ref ref;

  HomeNotifier(this.ref) : super(AsyncLoading());

  Future<void> fetchHomeData() async {
    final apiService = ref.read(apiServiceProvider);
    try {
      final response = await apiService.get(ApiEndpoints.home);
      logger.i(response);
      if (response.statusCode == StatusCode.OK) {
        logger.i(response.data["data"]);
        final userJson = response.data["data"]["user"];
        ref.read(userProvider.notifier).initialize(userJson);
        state = AsyncData(HomeModel.fromJson(response.data["data"]));
      } else {
        state = AsyncError(
            'Failed to load data. Status: ${response.statusCode}',
            StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncError(e.toString(), stackTrace);
    }
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, AsyncValue<HomeModel>>(
    (ref) => HomeNotifier(ref));

// final homeProvider = FutureProvider<HomeModel>((ref) async {
//   final apiService = ref.read(apiServiceProvider);
//
//   final response = await apiService.get(ApiEndpoints.home);
//   logger.i(response);
//
//   if (response.statusCode == 200) {
//     final userJson = response.data["data"]["user"];
//     ref.read(userProvider.notifier).initialize(userJson);
//
//     final homeResponse = HomeModel.fromJson(response.data);
//     logger.i(homeResponse);
//     return homeResponse;
//   } else {
//     throw Exception('Failed to load home data');
//   }
// });
