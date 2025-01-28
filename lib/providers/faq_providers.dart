import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/Response/faq_response_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

final faqProvider = FutureProvider<List<Data>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(ApiEndpoints.faq);
  FAQResposeModel faqResposeModel = FAQResposeModel.fromJson(response);
  return faqResposeModel.data!;
});
