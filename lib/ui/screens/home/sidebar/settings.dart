import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/providers/auth/delete_account_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_outline_button.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteAccountState = ref.watch(deleteAccountProvider);
    final deleteAccountNotifier = ref.read(deleteAccountProvider.notifier);

    ref.listen(deleteAccountProvider, (prev, current) {
      if (current.isSuccess == true) {
        context.go(RouterPath.signIn);
      }
    });

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
                  text: deleteAccountState.isLoading
                      ? "Deleting..."
                      : 'Delete Account',
                  onPressed: deleteAccountState.isLoading
                      ? null
                      : () async {
                          deleteAccountNotifier.deleteAccount();
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
