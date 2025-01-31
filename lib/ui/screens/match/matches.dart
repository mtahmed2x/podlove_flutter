import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/providers/matches_providers.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class Matches extends ConsumerWidget {
  const Matches({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final matchState = ref.watch(matchProvider);
    final matchNotifier = ref.read(matchProvider.notifier);

    ref.listen(matchProvider, (prev, current) {
      if (current.isSuccess!) {
        context.push(RouterPath.home);
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: "Matches"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10)
              .copyWith(top: 20, bottom: 44),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/flower.png"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withAlpha(128),
                            BlendMode.modulate,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            "assets/images/podLove.png",
                            width: 250,
                            height: 50,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'We have found potential matches for you!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/match-1.png"),
                          Image.asset("assets/images/match-2.png"),
                          Image.asset("assets/images/match-3.png"),
                        ],
                      ),
                      const SizedBox(height: 200),
                      CustomText(
                        text:
                            "The schedule for your podcast\nepisodes will be shared with you\nsoon.",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      CustomRoundButton(
                          text: matchState.isLoading
                              ? "Continuing..."
                              : "Continue",
                          onPressed: matchState.isLoading
                              ? null
                              : () async {
                                  await matchNotifier.match(userState!.user.id);
                                }),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
