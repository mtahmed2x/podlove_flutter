import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class PurchaseState {
  final String? url;

  PurchaseState({
    this.url,
  });

  factory PurchaseState.initial() {
    return PurchaseState(
      url: null,
    );
  }

  PurchaseState copyWith({
    String? url,
  }) {
    return PurchaseState(
      url: url ?? this.url,
    );
  }
}

class PurchaseNotifier extends StateNotifier<PurchaseState> {
  final ApiServices apiService;

  PurchaseNotifier(this.apiService) : super(PurchaseState());

  Future<void> purchase(String id) async {
    final purchaseData = {
      "planId": id,
    };

    final response = await apiService.post(
      ApiEndpoints.purchase,
      data: purchaseData,
    );
    if (response.statusCode == 200) {
      logger.i(response.data);
      logger.i(response.data["data"]);
    }
  }
}

final purchaseProvider = StateNotifierProvider<PurchaseNotifier, PurchaseState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return PurchaseNotifier(apiService);
  },
);
