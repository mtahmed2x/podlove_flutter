import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/Response/term_response_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

final termProvider = FutureProvider<String>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(ApiEndpoints.terms);
  TermResposeModel termResposeModel = TermResposeModel.fromJson(response);
  return termResposeModel.data!.text;
});
