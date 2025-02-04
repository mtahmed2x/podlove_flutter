import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/subscriptionProvider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class ChooseSubscription extends ConsumerStatefulWidget {
  const ChooseSubscription({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChooseSubscriptionState();

}

class _ChooseSubscriptionState extends ConsumerState<ChooseSubscription> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscription Plan"),
      body: Consumer(
        builder: (context, watch, child) {
          final asyncSubscription = ref.watch(subscriptionProvider);
          return Column(
            children: [
              asyncSubscription.when(
                data: (subscription) {

                  return Column(
                    children: [
                      Text(subscription.name ?? 'No Name'),
                      Text(subscription.unitAmount ?? 'No Amount'),
                      // You can add more fields as needed
                      ElevatedButton(
                        onPressed: () {
                          context.read(subscriptionProvider.notifier).fetchSubscriptionData();
                        },
                        child: Text('Fetch Subscription Data'),
                      ),
                    ],
                  );
                },
                loading: () {
                  return CircularProgressIndicator();
                },
                error: (error, stackTrace) {
                  return Text('Error: $error');
                },
              ),
            ],
          );
        },
      ),
    );
  }

}