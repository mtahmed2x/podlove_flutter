import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

final selectedInterestsProvider =
    StateProvider<Set<String>>((ref) => <String>{});

class SelectInterests extends ConsumerWidget {
  const SelectInterests({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);
    final selectedInterests = ref.watch(selectedInterestsProvider);
    final selectedInterestsNotifier =
        ref.read(selectedInterestsProvider.notifier);

    final interests = [
      "Photography",
      "Cooking",
      "Fitness",
      "Music",
      "Shopping",
      "Travelling",
      "Drinking",
      "Video Games",
      "Art & Crafts",
      "Swimming",
      "Extreme Sports",
      "Speeches",
    ];

    return Scaffold(
      appBar: CustomAppBar(title: "Likes & Interests"),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(12, 255, 161, 117), Color.fromARGB(110, 255, 255, 255)], // Two colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: "Tell us what you enjoy",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: "Please select at least 3",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 3.5,
                    ),
                    itemCount: interests.length,
                    itemBuilder: (context, index) {
                      final interest = interests[index];
                      final isSelected = selectedInterests.contains(interest);

                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedInterestsNotifier.state = {
                              ...selectedInterests
                            }..remove(interest);
                          } else {
                            selectedInterestsNotifier.state = {
                              ...selectedInterests
                            }..add(interest);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.background,

                            border: Border.all(
                              color: isSelected ? AppColors.accent : AppColors.background,
                            ),
                            borderRadius: BorderRadius.circular(60.r),
                          ),
                          child: Center(
                            child: Text(
                              interest,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.orange : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(userProvider);
                    return CustomRoundButton(
                      text: state?.isLoading == true ? "Saving..." : "Continue",
                      onPressed: state?.isLoading == true ||
                              selectedInterests.length < 3
                          ? null
                          : () async {
                              userNotifier
                                  .updateInterests(selectedInterests.toList());
                              userNotifier.update();
                              context.push(RouterPath.home);
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
