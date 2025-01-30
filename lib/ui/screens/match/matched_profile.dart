import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class MatchedProfile extends ConsumerWidget {
  final int index;
  final String? id;
  final String? name;
  final String? bio;
  final List<String>? interests;

  const MatchedProfile({
    super.key,
    required this.id,
    required this.index,
    required this.bio,
    required this.name,
    required this.interests,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);

    return Scaffold(
      appBar: CustomAppBar(title: "$name Bio"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/flower.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        AppWidgets.podLoveLogo,
                        const SizedBox(height: 20),
                        Text(
                          "$name",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: "",
                      maxLines: 5,
                      hint: bio,
                    ),
                    const SizedBox(height: 20),
                    CustomText(
                      text: "Interests:",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    const SizedBox(height: 20),
                    InterestGrid(
                      interests: interests!,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.push(RouterPath.chat, extra: {
                            "userId": userData!.user.id,
                            "receiverId": id,
                            "name": name
                          });
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/message.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(32),
                            border:
                                Border.all(color: AppColors.accent, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterestGrid extends StatelessWidget {
  final List<String> interests;

  const InterestGrid({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children:
          interests.map((interest) => InterestButton(label: interest)).toList(),
    );
  }
}

class InterestButton extends StatelessWidget {
  final String label;

  const InterestButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.accent,
        ),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
