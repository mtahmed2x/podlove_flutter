import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () =>
              GoRouter.of(context).go('${RouterPath.compatibalityQuestion}/1'),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
