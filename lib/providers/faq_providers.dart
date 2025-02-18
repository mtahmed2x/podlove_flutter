import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/faq_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

final faqProvider = FutureProvider<List<FaqModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(ApiEndpoints.faq);
  List<FaqModel> faqs = FaqModel.fromJsonList(response.data["data"]);
  return faqs;
});


