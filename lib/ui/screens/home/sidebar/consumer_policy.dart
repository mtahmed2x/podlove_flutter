import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/consumer_providers.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class ConsumerPolicy extends ConsumerWidget {
  const ConsumerPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consumerPolicyAsyncValue = ref.watch(consumerProvider);
    return Scaffold(
      appBar: CustomAppBar(title: "Consumer Policy", isLeading: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: consumerPolicyAsyncValue.when(
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
