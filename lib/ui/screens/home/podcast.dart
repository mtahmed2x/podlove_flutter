import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class PodcastPage extends ConsumerWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final homeData = ref.watch(homeProvider);

    final int appID = 1569445028;
    final String appSign =
        "f0e166fe2cb1cebc5dccdf2f7843c4d7a92eeecd54d31cc74ef564474b502904";

    String userID = userState!.user.id;
    String userName = userState.user.name;

    return homeData.when(
      data: (data) {
        String callID = data.podcast!.id!;

        return ZegoUIKitPrebuiltCall(
          appID: appID,
          appSign: appSign,
          userID: userID,
          userName: userName,
          callID: callID,
          config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Failed to load home data: ${error.toString()}'),
      ),
    );
  }
}
