import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';


class Matches extends StatelessWidget {
  const Matches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Matches"),
      body: SafeArea(
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
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
                    text: "Continue",
                    onPressed: () => context.push(RouterPath.home),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}