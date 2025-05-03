import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class BioCheckState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  BioCheckState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory BioCheckState.initial() {
    return BioCheckState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  BioCheckState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return BioCheckState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class BioCheckNotifier extends StateNotifier<BioCheckState> {
  final Ref ref;

  BioCheckNotifier(this.ref) : super(BioCheckState.initial());

  Future<void> bioCheck(String bio) async {
    state = state.copyWith(isLoading: true);
    final apiService = ref.read(apiServiceProvider);
    try {
      final response = await apiService.post(
        ApiEndpoints.bioCheck,
        data: {"text": bio},
      );
      logger.i(response);
      if (response.statusCode == StatusCode.OK) {
        state = state.copyWith(isSuccess: true);
      } else {
        state =
            state.copyWith(isSuccess: false, error: response.data['message']);
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

final bioCheckProvider =
StateNotifierProvider<BioCheckNotifier, BioCheckState>(
        (ref) => BioCheckNotifier(ref));
