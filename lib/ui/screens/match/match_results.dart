import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';


class MatchResults extends StatelessWidget {
  const MatchResults ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Match Results"),
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
                            Colors.white.withAlpha(128), BlendMode.modulate)),
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
                        'Get Ready For Your Podcast Experiences!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Image.asset("assets/images/congrats.png"),
            const SizedBox(height: 40),
            CustomText(
              text: "Congratulations",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 35, 104, 191),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CustomText(
                text: "You have been matched",
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
            CustomText(
              text: "You will meet them during your\npodcast episode.",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            CustomRoundButton(
              text: "Continue",
              onPressed: () => context.push(RouterPath.matches),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}