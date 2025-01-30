import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';


class FindingMatch extends StatelessWidget {
  const FindingMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Finding Matches"),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => context.push(RouterPath.matchResults),
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
                          'Your Connection Begins Here',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Our smart AI connector is working hard to find the best matches for you.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
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
              // Circular Progress Indicator with a solid circle inside
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Circular Progress
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: 0.74, // Progress percentage (0 to 1)
                        strokeWidth: 20,
                        color: Color.fromARGB(255, 255, 161, 117),
                        backgroundColor: Color.fromARGB(255, 235, 235, 235),
                      ),
                    ),

                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 161, 117),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '74%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 254, 254, 254),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                'Finding matches...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 63, 63, 63),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}