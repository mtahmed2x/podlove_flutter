import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class ConnectionPathwayState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  ConnectionPathwayState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory ConnectionPathwayState.initial() {
    return ConnectionPathwayState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  ConnectionPathwayState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ConnectionPathwayState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class ConnectionPathwayNotifier extends StateNotifier<ConnectionPathwayState> {
  final Ref ref;

  ConnectionPathwayNotifier(this.ref) : super(ConnectionPathwayState.initial());

  Future<void> isSuitable(List<String> userResponses) async {
    state = state.copyWith(isLoading: true);
    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.post(
        ApiEndpoints.connectionPathway,
        data: {"userResponses": userResponses},
      );

      if (response.statusCode == StatusCode.OK) {
        logger.i(response.data["data"]["isSuitable"]);
        final isSuitable = response.data["data"]["isSuitable"] == true;
        state = state.copyWith(isSuccess: isSuitable);
      } else {
        state = state.copyWith(isSuccess: false);
      }
    } catch (e) {
      state = state.copyWith(
        isSuccess: false,
        error: "An unexpected error occurred. Please try again.",
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final connectionPathwayProvider =
    StateNotifierProvider<ConnectionPathwayNotifier, ConnectionPathwayState>(
        (ref) => ConnectionPathwayNotifier(ref));
