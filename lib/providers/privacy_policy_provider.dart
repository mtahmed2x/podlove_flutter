import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/privacy_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

final privacyPolicyProvider = FutureProvider<String>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(ApiEndpoints.privacy);
  PrivacyModel privacy =
      PrivacyModel.fromJson(response.data["data"]);
  return privacy.text;
});
