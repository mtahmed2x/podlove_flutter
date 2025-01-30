import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class PodcastDetails extends ConsumerWidget {
  const PodcastDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);

    return Scaffold(
      appBar: CustomAppBar(title: "Podcast Details"),
      body: SafeArea(
        child: homeData.when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        AppWidgets.podLoveLogo,
                        SizedBox(height: 20),
                        Image.asset(
                          "assets/images/calendar.png",
                          width: 79,
                          height: 79,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick-image.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          CustomText(
                            text: 'Time: ',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: '${data.podcast!.schedule!.day} ${data.podcast!.schedule!.time}',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick-image.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          CustomText(
                            text: 'Format: ',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: 'Audio & Video',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: CustomText(
                      text: 'REMEMBER',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 39, 87, 166),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  ReminderItem(
                    text: 'Relax and be yourself',
                    path: "assets/images/hand-point.png",
                  ),
                  ReminderItem(
                    text:
                        'Have a quiet space with good lighting and stable internet connection',
                    path: "assets/images/hand-point.png",
                  ),
                  ReminderItem(
                    text: 'The host will guide you through the process',
                    path: "assets/images/hand-point.png",
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            print(error);
            print(stack.toString());
            return Center(child: Text("Error: ${error.toString()}"));
          },
        ),
      ),
    );
  }
}

class ReminderItem extends StatelessWidget {
  final String text;
  final String path;

  const ReminderItem({super.key, required this.text, required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            path,
            height: 24,
            width: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
