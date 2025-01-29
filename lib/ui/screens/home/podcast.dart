import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  final int appID = 1569445028;
  final String appSign =
      "f0e166fe2cb1cebc5dccdf2f7843c4d7a92eeecd54d31cc74ef564474b502904";
  final String callID = "test";
  final String userID = "Tanim";
  final String userName = "Tanim";

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: appID,
        appSign: appSign,
        userID: userID,
        userName: userName,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()..avatarBuilder);
  }
}
