import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/home_response_model.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'global_providers.dart';

final homeProvider = FutureProvider<HomeResponse>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(ApiEndpoints.home);

  if (response.statusCode == 200) {
    final homeResponse = HomeResponse.fromJson(response.data);
    logger.i(homeResponse);
    return homeResponse;
  } else {
    throw Exception('Failed to load home data');
  }
});
