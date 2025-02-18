import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/delete_account_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_outline_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteAccountState = ref.watch(deleteAccountProvider);
    final deleteAccountNotifier = ref.read(deleteAccountProvider.notifier);

    ref.listen<DeleteAccountState>(deleteAccountProvider, (prev, current) {
      if (current.isSuccess == true && current.isLoading == false) {
        context.go(RouterPath.signIn);
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
        isLeading: true,
      ),
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
                      : () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: CustomText(
                                  text: "Are you sure?",
                                  color: AppColors.primaryText,
                                ),
                                content: const Text(
                                  'Are you sure you want to delete your account?',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: CustomText(
                                      text: "Nevermind",
                                      color: AppColors.primaryText,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: CustomText(
                                      text: "Yes",
                                      color: AppColors.primaryText,
                                    ),
                                    onPressed: () async {
                                      deleteAccountNotifier.deleteAccount();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
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
