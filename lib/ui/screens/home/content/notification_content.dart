import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

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
              NotificationWidget(
                iconURL: "assets/images/podcast-icon.png",
                heading: "Podcast episode is coming up!",
                description: "Here’s how to prepare and what to expect",
                date: "12:28 PM",
              ),
              NotificationWidget(
                iconURL: "assets/images/feedback-icon.png",
                heading: "Share your feedback",
                description: "Please fill the the survey form",
                date: "12:09 PM",
              ),
              NotificationWidget(
                iconURL: "assets/images/invite-icon.png",
                heading: "You’re invited!",
                description: "You have podcast on 12/04/24 at 5 pm",
                date: "04:51 PM",
              ),
              NotificationWidget(
                iconURL: "assets/images/payment-icon.png",
                heading: "Payment success!",
                description:
                    "You’ve successfully subscribe a Tippz to [Player/Team]!",
                date: "Yesterday",
              ),
              NotificationWidget(
                iconURL: "assets/images/podcast-icon.png",
                heading: "Podcast scheduled!",
                description: "The podcast will be held on 12/04/24 at 5 pm",
                date: "12/08/24",
              ),
              NotificationWidget(
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
