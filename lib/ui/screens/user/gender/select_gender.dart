import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_circle_group.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class SelectGender extends ConsumerWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.read(userProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.selectGenderTitle),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Center(
                      child: Column(
                        children: [
                          AppWidgets.podLoveLogo,
                          SizedBox(height: 25.h),
                          CustomText(
                            text: AppStrings.genderQuestion,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 40.h),
                          CustomCircleGroup(
                            labels: [
                              AppStrings.female,
                              AppStrings.male,
                              AppStrings.nonBinary,
                              AppStrings.transgender,
                              AppStrings.genderFluid,
                            ],
                            onCircleSelected: (index) {
                              final gender = [
                                AppStrings.female,
                                AppStrings.male,
                                AppStrings.nonBinary,
                                AppStrings.transgender,
                                AppStrings.genderFluid,
                              ][index];
                              userNotifier.updateGender(gender);
                            },
                          ),
                          SizedBox(height: 50.h),
                          Consumer(
                            builder: (context, ref, _) {
                              final state = ref.watch(userProvider);
                              return CustomRoundButton(
                                text: AppStrings.continueButton,
                                onPressed: state?.user.gender.isNotEmpty == true
                                    ? () => GoRouter.of(context)
                                        .go(RouterPath.selectPreferredGender)
                                    : null,
                              );
                            },
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
