import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_outline_button.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomOutlineButton(
                  icon: Icons.key,
                  text: 'Change Password',
                  onPressed: () {
                    context.push(RouterPath.changePassword);
                  },
                ),
                const SizedBox(height: 16),
                CustomOutlineButton(
                  icon: Icons.delete,
                  text: 'Delete Account',
                  onPressed: () {
                    print('Delete Account pressed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
