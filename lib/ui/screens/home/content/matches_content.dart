import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class MatchesContent extends ConsumerWidget {
  const MatchesContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);

    return Scaffold(
      appBar: CustomAppBar(title: "Matches"),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
                child: homeData.when(
              data: (data) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        data.podcast!.status != "Done"
                            ? "assets/images/hidden-match.png"
                            : "assets/images/revealed-match.png",
                        width: 335,
                        height: 302,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Image.asset(
                      "assets/images/hidden-match.png",
                      width: 335,
                      height: 302,
                    ),
                    const SizedBox(height: 30),
                    Image.asset(
                      "assets/images/hidden-match.png",
                      width: 335,
                      height: 302,
                    ),
                  ],
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Failed to load home data: ${error.toString()}'),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
