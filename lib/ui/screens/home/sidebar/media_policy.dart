import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/media_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class MediaPolicy extends ConsumerWidget {
  const MediaPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaPolicyAsyncValue = ref.watch(mediaProvider);
    return Scaffold(
      appBar: CustomAppBar(title: "Media Policy", isLeading: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: mediaPolicyAsyncValue.when(
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
