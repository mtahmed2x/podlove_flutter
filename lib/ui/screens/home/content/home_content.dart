import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/data/models/home_response_model.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/providers/purchase_providers.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_image_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/reuseable_header.dart';
import 'package:podlove_flutter/ui/widgets/subscription_card.dart';
import 'package:podlove_flutter/utils/logger.dart';

class HomeContent extends ConsumerWidget {
  final VoidCallback onMenuTap;

  const HomeContent({
    required this.onMenuTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);
    final userState = ref.watch(userProvider);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(homeProvider);
        },
        child: SingleChildScrollView(
          child: homeData.when(
            data: (data) {
              String schedule = "TBD";
              if (data.podcast?.schedule?.date != null &&
                  data.podcast!.schedule!.date != "") {
                schedule =
                    "${data.podcast!.schedule!.date} (${data.podcast!.schedule!.day}) ${data.podcast!.schedule!.time}";
              }
              return Column(
                children: [
                  if (userState != null)
                    ReusableHeader(
                      name: userState.user.name,
                      greeting: "Hello!",
                      url: userState.user.avatar,
                      onMenuTap: onMenuTap,
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            // Matches section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Your Matches",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      data.podcast?.status != "Done"
                                          ? "assets/images/match-1.png"
                                          : "assets/images/match-revealed.png",
                                    ),
                                    Image.asset("assets/images/match-2.png"),
                                    Image.asset("assets/images/match-3.png"),
                                  ],
                                ),
                                if (data.podcast?.status == "Done") ...[
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomImageButton(
                                        imagePath:
                                            "assets/images/btn-active.png",
                                        text: "Chat",
                                        onPressed: () =>
                                            context.push(RouterPath.chat),
                                      ),
                                      CustomImageButton(
                                        imagePath:
                                            "assets/images/btn-inactive.png",
                                        text: "Chat",
                                        onPressed: () {},
                                      ),
                                      CustomImageButton(
                                        imagePath:
                                            "assets/images/btn-inactive.png",
                                        text: "Chat",
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ]
                              ],
                            ),
                            const SizedBox(height: 30),
                            // Podcast Schedules Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Podcast Schedules",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () => data.podcast!.status != "Done"
                                      ? context.push(RouterPath.podcastDetails)
                                      : null,
                                  child: Container(
                                    width: 400,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/schedule.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'Date & Time:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          schedule,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 25),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 20.0,
                                          ),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () => {
                                                context.push(RouterPath.podcast)
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.accent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 15,
                                                ),
                                              ),
                                              child: CustomText(
                                                text: data.podcast!.status ==
                                                        "Scheduled"
                                                    ? "Join"
                                                    : "Schedule",
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            if (userState != null)
                              _buildSubscriptionPlansSection(
                                data.subscriptionPlans!,
                                userState.user.subscription.plan,
                                context,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
      ),
    );
  }

  Widget _buildSubscriptionPlansSection(
    List<SubscriptionPlan> subscriptionPlans,
    String subscriptionName,
    BuildContext context,
  ) {
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
            children: subscriptionPlans.map((subscriptionPlan) {
              bool isCurrentPlan = subscriptionName == subscriptionPlan.name;

              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: _buildSubscriptionPlanCard(
                  id: subscriptionPlan.id!,
                  plan: subscriptionPlan.name!,
                  price: subscriptionPlan.unitAmount == "0"
                      ? "Free / ${subscriptionPlan.interval}"
                      : "${subscriptionPlan.unitAmount!} / ${subscriptionPlan.interval}",
                  features: subscriptionPlan.description!
                      .map((desc) => desc.key ?? '')
                      .take(3)
                      .toList(),
                  isCurrentPlan: isCurrentPlan,
                  subscriptionPlan: subscriptionPlan,
                  context: context,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionPlanCard({
    required String id,
    required String plan,
    required String price,
    required List<String> features,
    required bool isCurrentPlan,
    required SubscriptionPlan subscriptionPlan,
    required BuildContext context,
  }) {
    List<String> parts = plan.split(':') ?? ["", ""];
    return Consumer(
      builder: (context, ref, _) {
        final purchaseNotifier = ref.read(purchaseProvider.notifier);
        return SubscriptionCard(
          title: parts[0],
          subtitle: parts[1].trim(),
          price: price,
          features: features,
          onViewDetails: () => showSubscriptionDetails(
            context,
            plan,
            price,
            subscriptionPlan.description!
                .map((desc) => {
                      "key": desc.key ?? "",
                      "details": desc.details ?? "",
                    })
                .toList(),
          ),
          isCurrentPlan: isCurrentPlan,
          onPressed: isCurrentPlan
              ? () {}
              : () {
                  () async {
                    logger.i("tap");
                    final url = await purchaseNotifier.purchase(id);
                    context.push(RouterPath.purchase, extra: url);
                  }();
                },
        );
      },
    );
  }
}

void showSubscriptionDetails(
  BuildContext context,
  String title,
  String price,
  List<Map<String, String>> features,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button (top right corner)
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.orange),
                ),
              ),

              // Title
              Center(
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Subscription Name & Price
              Text(
                "$title ($price)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Description Title
              Text(
                "Everything in the Listener package, plus:",
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 8),

              // Features List (Bold key + Normal details)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ", style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "${feature['key']}: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: feature['details'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
