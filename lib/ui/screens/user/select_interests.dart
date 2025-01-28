import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

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

    final isLoading = userState?.isLoading ?? false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Likes & Interests",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Tell us what you enjoy",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "Please select at least 3",
                color: Colors.grey,
              ),
              SizedBox(height: 16.h),
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
                          color: isSelected ? Colors.orange[100] : Colors.white,
                          border: Border.all(
                            color: isSelected ? Colors.orange : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            interest,
                            style: TextStyle(
                              color: isSelected ? Colors.orange : Colors.black,
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
                            // GoRouter.of(context).go(RouterPath.homeBefore);
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
