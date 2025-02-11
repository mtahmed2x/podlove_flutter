import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/purchase_providers.dart';
import 'package:podlove_flutter/providers/subscriptionProvider.dart';
import 'package:podlove_flutter/routes/app_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/subscription_card.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseSubscription extends ConsumerStatefulWidget {
  const ChooseSubscription({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChooseSubscriptionState();
}

class _ChooseSubscriptionState extends ConsumerState<ChooseSubscription> {
  @override
  void initState() {
    super.initState();
    ref.read(subscriptionProvider.notifier).fetchSubscriptionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscription Plan"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w)
            .copyWith(top: 20.h, bottom: 44.h),
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final asyncSubscriptions = ref.watch(subscriptionProvider);
                  return asyncSubscriptions.when(
                    data: (subscriptions) {
                      final purchaseNotifier =
                      ref.read(purchaseProvider.notifier);
                      return ListView.builder(
                        itemCount: subscriptions.length,
                        itemBuilder: (context, index) {
                          final subscription = subscriptions[index];
                          final features = subscription.description!
                              .map((desc) => desc.key ?? '')
                              .take(3)
                              .toList();
                          final isCurrentPlan = index == 0;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.0.h),
                            child: SubscriptionCard(
                                width: 100,
                                title: subscription.name!.split(":")[0],
                                subtitle: subscription.name!.split(":")[1],
                                price: subscription.unitAmount == "0"
                                    ? "Free / ${subscription.interval}"
                                    : "${subscription.unitAmount!} / ${subscription.interval}",
                                features: features,
                                onPressed: isCurrentPlan
                                    ? () {}
                                    : () {
                                  () async {
                                    final url = await purchaseNotifier
                                        .purchase(subscription.id!);
                                    context.push(
                                      RouterPath.purchase,
                                      extra: {
                                        "url": url,
                                        "onPressed": () {
                                          context.push(
                                              RouterPath.findingMatch);
                                        }
                                      },
                                    );
                                  }();
                                },
                                isCurrentPlan: isCurrentPlan,
                                onViewDetails: () => showSubscriptionDetails(
                                  context,
                                  subscription.name!,
                                  subscription.unitAmount!,
                                  subscription.description!
                                      .map((desc) => {
                                    "key": desc.key ?? "",
                                    "details": desc.details ?? "",
                                  })
                                      .toList(),
                                )),
                          );
                        },
                      );
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('Error: $error'),
                  );
                },
              ),
            ),
            CustomRoundButton(
              text: 'Continue',
              backgroundColor: AppColors.accent,
              onPressed: () => context.push(RouterPath.findingMatch),
            ),
          ],
        ),
      ),
    );
  }
}
