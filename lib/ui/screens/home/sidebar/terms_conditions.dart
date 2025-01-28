import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/term_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class TermsConditions extends ConsumerWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termAsyncValue = ref.watch(termProvider);
    return Scaffold(
      appBar: CustomAppBar(title: "Terms & Conditions"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: termAsyncValue.when(
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
