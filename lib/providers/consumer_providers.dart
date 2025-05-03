import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/cosumer_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

final consumerProvider = FutureProvider<String>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(ApiEndpoints.consumer);
  ConsumerModel term = ConsumerModel.fromJson(response.data["data"]);
  return term.text;
});
