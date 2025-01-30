import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/home_response_model.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'global_providers.dart';

final homeProvider = FutureProvider<HomeData>((ref) async {
  final apiService = ref.read(apiServiceProvider);

  final response = await apiService.get(ApiEndpoints.home);
  logger.i(response);

  if (response.statusCode == 200) {
    final userJson = response.data["data"]["user"];
    ref.read(userProvider.notifier).initialize(userJson);

    final homeResponse = HomeResponseModel.fromJson(response.data);
    logger.i(homeResponse);
    return homeResponse.data!;
  } else {
    throw Exception('Failed to load home data');
  }
});
