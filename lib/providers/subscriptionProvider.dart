import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/subscription_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SubscriptionNotifier
    extends StateNotifier<AsyncValue<List<SubscriptionModel>>> {
  final Ref ref;

  SubscriptionNotifier(this.ref) : super(AsyncLoading());

  Future<void> fetchSubscriptionData() async {
    final apiServices = ref.watch(apiServiceProvider);
    try {
      final response = await apiServices.get(ApiEndpoints.subscriptionPlan);
      logger.i(response);
      if (response.statusCode == StatusCode.OK) {
        final List<dynamic> jsonList = response.data["data"];
        logger.i(response.data["data"]);
        state = AsyncData(SubscriptionModel.fromJsonList(jsonList));
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

final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier,
    AsyncValue<List<SubscriptionModel>>>((ref) => SubscriptionNotifier(ref));
