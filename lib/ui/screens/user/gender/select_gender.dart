import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_circle_group.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SelectGender extends ConsumerWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    final error = userState?.error;

    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.selectGenderTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
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
                        color: AppColors.primaryText,
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
                          // Update the selected gender in the state
                          final selectedGender = [
                            AppStrings.female,
                            AppStrings.male,
                            AppStrings.nonBinary,
                            AppStrings.transgender,
                            AppStrings.genderFluid,
                          ][index];
                          userNotifier.updateGender(selectedGender);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(userProvider);
                    return CustomRoundButton(
                      text: state?.isLoading == true
                          ? AppStrings.saving
                          : AppStrings.continueButton,
                      onPressed: state?.isLoading == true
                          ? null
                          : () {
                              if (state?.user.gender == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select your gender'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              logger.i(state?.user.gender);
                              context.go(RouterPath
                                  .selectPreferredGender); // Navigate to the next screen
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
