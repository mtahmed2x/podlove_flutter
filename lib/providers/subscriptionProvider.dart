import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/models/subscription_model.dart';
import 'package:podlove_flutter/providers/global_providers.dart';

class SubscriptionNotifier extends StateNotifier<AsyncValue<SubscriptionModel>> {
  final Ref ref;

  SubscriptionNotifier(this.ref) : super(AsyncLoading());

  Future<void> fetchSubscriptionData() async {
    final apiServices = ref.watch(apiServiceProvider);
    try {
      final response = await apiServices.get(ApiEndpoints.subscriptionPlan);

      if (response.statusCode == StatusCode.OK) {
        final jsonData = response.data["data"];
        if (jsonData != null) {
          state = AsyncData(SubscriptionModel.fromJson(jsonData));
        } else {
          state = AsyncError('No data found in the response', StackTrace.current);
        }
      } else {
        state = AsyncError('Failed to load data. Status: ${response.statusCode}', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncError(e.toString(), stackTrace);
    }
  }
}

final subscriptionProvider =
StateNotifierProvider<SubscriptionNotifier, AsyncValue<SubscriptionModel>>(
        (ref) => SubscriptionNotifier(ref));
