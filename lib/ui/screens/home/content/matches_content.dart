import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class MatchesContent extends StatelessWidget {
  const MatchesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Matches"),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/images/revealed-match.png",
                      width: 335,
                      height: 302,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    "assets/images/hidden-match.png",
                    width: 335,
                    height: 302,
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    "assets/images/hidden-match.png",
                    width: 335,
                    height: 302,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
