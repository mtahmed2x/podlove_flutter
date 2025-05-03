import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/media_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

final mediaProvider = FutureProvider<String>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(ApiEndpoints.media);
  MediaModel media = MediaModel.fromJson(response.data["data"]);
  return media.text;
});
