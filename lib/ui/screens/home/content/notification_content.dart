import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class NotificationContent extends StatelessWidget {
  const NotificationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      appBar: CustomAppBar(title: "Notifications"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _NotificationWidget(
                iconURL: "assets/images/podcast-icon.png",
                heading: "Podcast episode is coming up!",
                description: "Here’s how to prepare and what to expect",
                date: "12:28 PM",
              ),
              _NotificationWidget(
                iconURL: "assets/images/feedback-icon.png",
                heading: "Share your feedback",
                description: "Please fill the the survey form",
                date: "12:09 PM",
              ),
              _NotificationWidget(
                iconURL: "assets/images/invite-icon.png",
                heading: "You’re invited!",
                description: "You have podcast on 12/04/24 at 5 pm",
                date: "04:51 PM",
              ),
              _NotificationWidget(
                iconURL: "assets/images/payment-icon.png",
                heading: "Payment success!",
                description:
                    "You’ve successfully subscribe a Tippz to [Player/Team]!",
                date: "Yesterday",
              ),
              _NotificationWidget(
                iconURL: "assets/images/podcast-icon.png",
                heading: "Podcast scheduled!",
                description: "The podcast will be held on 12/04/24 at 5 pm",
                date: "12/08/24",
              ),
              _NotificationWidget(
                iconURL: "assets/images/podcast-icon.png",
                heading: "Upgrade today!",
                description:
                    "Unlock exclusive features like advanced compatibility insights with our premium package.",
                date: "15/08/24",
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class _NotificationWidget extends StatelessWidget {
  final String iconURL;
  final String heading;
  final String description;
  final String date;

  const _NotificationWidget({
    required this.iconURL,
    required this.heading,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 232, 232, 232),
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconURL,
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: heading,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: description,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        text: date,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 92, 92, 92),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
