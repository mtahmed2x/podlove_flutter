import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/data/services/api_exceptions.dart';

class GlobalErrorHandler extends ProviderObserver {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  GlobalErrorHandler(this.scaffoldMessengerKey);

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    if (newValue is ApiException) {
      _showErrorSnackBar(newValue.message);
    }
  }

  void _showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
