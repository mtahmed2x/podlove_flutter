import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/providers/faq_providers.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class FAQ extends ConsumerStatefulWidget {
  const FAQ({super.key});

  @override
  ConsumerState<FAQ> createState() => _FAQPageState();
}

class _FAQPageState extends ConsumerState<FAQ> {
  late List<bool> _isExpandedList;

  @override
  Widget build(BuildContext context) {
    final faqAsyncValue = ref.watch(faqProvider);

    return Scaffold(
      appBar: CustomAppBar(title: "FAQs"),
      body: faqAsyncValue.when(
        data: (faqs) {
          if (faqs.isEmpty) {
            return const Center(child: Text("No FAQs available"));
          }

          // Initialize the expansion state list if not already initialized
          _isExpandedList = List<bool>.filled(faqs.length, false);

          return SingleChildScrollView(
            child: Column(
              children: faqs.asMap().entries.map((entry) {
                final index = entry.key;
                final faq = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: ExpansionTile(
                    title: Text(
                      faq.question,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      _isExpandedList[index]
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        _isExpandedList[index] = isExpanded;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          faq.answer,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text("Failed to load FAQs: $error"),
        ),
      ),
    );
  }
}
