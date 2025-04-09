import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/home_model.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
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
      if (response.statusCode == StatusCode.OK) {
        final userJson = response.data["data"]["user"];
        ref.read(userProvider.notifier).initialize(userJson);
        final home = HomeModel.fromJson(response.data["data"]);
        logger.i(home.user!.name);
        state = AsyncData(home);
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
