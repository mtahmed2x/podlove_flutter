import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/privacy_policy_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class PrivacyPolicy extends ConsumerWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final privacyPolicyAsyncValue = ref.watch(privacyPolicyProvider);
    return Scaffold(
      appBar: CustomAppBar(title: "Privacy Policy"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: privacyPolicyAsyncValue.when(
          data: (htmlContent) {
            return Html(
              data: htmlContent,
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              'Error: $error',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
