import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/enums.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class HomeContent extends ConsumerWidget {
  final VoidCallback onMenuTap;
  final HomeContentType type;

  const HomeContent(
      {required this.onMenuTap, this.type = HomeContentType.before, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ReusableHeader(
              name: "Ronald Richards",
              greeting: "Hello!",
              url: "assets/images/profile-avatar.png",
              onMenuTap: onMenuTap,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMatchesSection(context),
                  const SizedBox(height: 30),
                  _buildPodcastScheduleSection(context),
                  const SizedBox(height: 30),
                  _buildSubscriptionPlansSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Your Matches",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(type == HomeContentType.before
                ? "assets/images/match-1.png"
                : "assets/images/match-revealed.png"),
            Image.asset("assets/images/match-2.png"),
            Image.asset("assets/images/match-3.png"),
          ],
        ),
        if (type == HomeContentType.after) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImageButton(
                imagePath: "assets/images/btn-active.png",
                text: "Chat",
                onPressed: () => context.push('/chat'),
              ),
              CustomImageButton(
                imagePath: "assets/images/btn-inactive.png",
                text: "Chat",
                onPressed: () {},
              ),
              CustomImageButton(
                imagePath: "assets/images/btn-inactive.png",
                text: "Chat",
                onPressed: () {},
              ),
            ],
          ),
        ]
      ],
    );
  }

  Widget _buildPodcastScheduleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Podcast Schedules",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => context.push('/podcast-details'),
          child: Container(
            width: 400,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage('assets/images/schedule.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Date & Time:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '12/07/24 (Monday) at 4 PM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => context.push(
                          type == HomeContentType.before
                              ? '/podcast-play'
                              : '/second-podcast-play'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        'Join',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionPlansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Subscription Plans",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildSubscriptionPlanCard(
                title: "Listener",
                subtitle: "Connection Starter",
                price: "Free",
                features: [
                  "Meet 2 Matches",
                  "Podcast Participation",
                  "72 Hours Chat Access",
                  "Podcast Exposure",
                ],
                isCurrentPlan: true,
              ),
              const SizedBox(width: 15),
              _buildSubscriptionPlanCard(
                title: "Speaker",
                subtitle: "Conversation Explorer",
                price: "\$14.99/month",
                features: [
                  "Meet 3 Matches",
                  "Podcast Participation",
                  "72 Hours Chat Access",
                  "Podcast Exposure",
                ],
                isCurrentPlan: false,
              ),
              const SizedBox(width: 15),
              _buildSubscriptionPlanCard(
                title: "Seeker",
                subtitle: "Connection Builder",
                price: "\$29.99/month",
                features: [
                  "Meet 4 Matches",
                  "Match Refresh",
                  "Unlimited Chat & Bios Access",
                  "Event Perks & Merch Discounts",
                ],
                isCurrentPlan: false,
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required List<String> features,
    required bool isCurrentPlan,
  }) {
    return SubscriptionPlanCard(
      title: title,
      subtitle: subtitle,
      price: price,
      features: features,
      onViewDetails: () => print("View Details clicked"),
      isCurrentPlan: isCurrentPlan,
    );
  }
}
