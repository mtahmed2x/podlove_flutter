import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/providers/purchase_providers.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_image_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/reuseable_header.dart';
import 'package:podlove_flutter/ui/widgets/subscription_card.dart';
import 'package:podlove_flutter/utils/logger.dart';

class HomeContent extends ConsumerStatefulWidget {
  final VoidCallback onMenuTap;

  const HomeContent({super.key, required this.onMenuTap});

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider.notifier).fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final shouldPop = await _showBackDialog() ?? false;
        if (context.mounted && shouldPop == true) {
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(homeProvider.notifier).fetchHomeData();
          },
          child: SingleChildScrollView(
            child: Consumer(builder: (context, ref, child) {
              final homeData = ref.watch(homeProvider);
              return homeData.when(
                data: (data) {
                  final userState = ref.watch(userProvider);
                  String schedule = "TBD";
                  if (data.podcast?.schedule?.date != null &&
                      data.podcast?.schedule?.date != "") {
                    schedule =
                        "${data.podcast?.schedule?.date} (${data.podcast?.schedule?.day}) ${data.podcast?.schedule?.time}";
                  }
                  return Column(
                    children: [
                      if (userState != null)
                        ReusableHeader(
                          name: data.user!.name,
                          greeting: "Hello!",
                          url: data.user!.avatar,
                          onMenuTap: widget.onMenuTap,
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
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        spacing: 10,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          data.podcast!.participants!.length,
                                          (index) => Image.asset(
                                              "assets/images/match-${index + 1}.png"),
                                        ),
                                      ),
                                    ),
                                    if (data.podcast?.status == "Done") ...[
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          data.podcast!.participants!.length,
                                          (index) => CustomImageButton(
                                            imagePath: index == 0
                                                ? "assets/images/btn-active.png"
                                                : "assets/images/btn-inactive.png",
                                            text: "Chat",
                                            onPressed: index == 0
                                                ? () => context
                                                    .push(RouterPath.chat)
                                                : () {},
                                          ),
                                        ),
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
                                      onTap: () => data.podcast!.status ==
                                              "Scheduled"
                                          ? context
                                              .push(RouterPath.podcastDetails)
                                          : null,
                                      child: Container(
                                        width: 400,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/images/schedule.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                              data.podcast!.status ==
                                                      "Scheduled"
                                                  ? schedule
                                                  : "TBD",
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
                                                    context.push(
                                                        RouterPath.podcast)
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.accent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 40,
                                                      vertical: 15,
                                                    ),
                                                  ),
                                                  child: CustomText(
                                                    text:
                                                        data.podcast!.status ==
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
                                SizedBox(
                                  height: 500,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.subscriptionPlans?.length,
                                    itemBuilder: (context, index) {
                                      final purchaseNotifier =
                                          ref.read(purchaseProvider.notifier);
                                      final subscription =
                                          data.subscriptionPlans![index];
                                      final features = subscription.description!
                                          .map((desc) => desc.key ?? '')
                                          .take(3)
                                          .toList();
                                      final isCurrentPlan =
                                          data.user!.subscription.plan ==
                                              subscription.name;
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: SubscriptionCard(
                                            title: subscription.name!
                                                .split(":")[0],
                                            subtitle: subscription.name!
                                                .split(":")[1],
                                            price: subscription.unitAmount ==
                                                    "0"
                                                ? "Free / ${subscription.interval}"
                                                : "${subscription.unitAmount!} / ${subscription.interval}",
                                            features: features,
                                            onPressed: isCurrentPlan
                                                ? () {}
                                                : () {
                                                    () async {
                                                      logger.i("tap");
                                                      final url =
                                                          await purchaseNotifier
                                                              .purchase(
                                                                  subscription
                                                                      .id!);
                                                      context.push(
                                                          RouterPath.purchase,
                                                          extra: url);
                                                    }();
                                                  },
                                            isCurrentPlan: isCurrentPlan,
                                            onViewDetails: () =>
                                                showSubscriptionDetails(
                                                  context,
                                                  subscription.name!,
                                                  subscription.unitAmount!,
                                                  subscription.description!
                                                      .map((desc) => {
                                                            "key":
                                                                desc.key ?? "",
                                                            "details":
                                                                desc.details ??
                                                                    "",
                                                          })
                                                      .toList(),
                                                )),
                                      );
                                    },
                                  ),
                                )
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
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            text: "Are you sure?",
            color: AppColors.primaryText,
          ),
          content: const Text(
            'Do you want to leave the app?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: CustomText(
                text: "No",
                color: AppColors.primaryText,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: CustomText(
                text: "Yes",
                color: AppColors.primaryText,
              ),
              onPressed: () async {
                Navigator.pop(context, true);
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
