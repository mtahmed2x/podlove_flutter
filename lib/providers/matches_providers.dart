import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class MatchState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  MatchState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory MatchState.initial() {
    return MatchState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  MatchState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return MatchState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class MatchNotifier extends StateNotifier<MatchState> {
  final ApiServices apiService;

  MatchNotifier(this.apiService) : super(MatchState());

  Future<void> match(String id) async {
    final matchData = {
      "primaryUser": id,
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        "/podcast/create",
        data: matchData,
      );
      logger.i(response);

      if (response.statusCode == 201) {
        state = state.copyWith(isSuccess: true);
      }
    } catch (e) {
      state = state.copyWith(
        isSuccess: false,
        error: "An unexpected error occurred. Please try again.",
        isLoading: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final matchProvider = StateNotifierProvider<MatchNotifier, MatchState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return MatchNotifier(apiService);
  },
);
