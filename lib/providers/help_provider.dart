import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/api_endpoints.dart';
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/utils/logger.dart';

class HelpState {
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  HelpState({
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  factory HelpState.initial() {
    return HelpState(
      isLoading: false,
      isSuccess: null,
      error: null,
    );
  }

  HelpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return HelpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class HelpNotifier extends StateNotifier<HelpState> {
  final ApiServices apiService;
  final Ref ref;

  HelpNotifier(this.apiService, this.ref) : super(HelpState());

  final issueController = TextEditingController();

  Future<void> submitHelp(String category) async {
    final userState = ref.watch(userProvider);

    final helpData = {
      "userId": userState!.user.id.toString(),
      "description": issueController.text
    };

    try {
      state = state.copyWith(isLoading: true);

      final response = await apiService.post(
        ApiEndpoints.help,
        data: helpData,
      );
      logger.i(response);
      if (response.statusCode == 201) {
        state = state.copyWith(
          isSuccess: true,
          isLoading: false,
        );
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

  @override
  void dispose() {
    issueController.dispose();
    super.dispose();
  }
}

final helpProvider = StateNotifierProvider<HelpNotifier, HelpState>(
  (ref) {
    final apiService = ref.read(apiServiceProvider);
    return HelpNotifier(apiService, ref);
  },
);
