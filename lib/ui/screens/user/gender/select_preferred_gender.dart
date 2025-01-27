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

class SelectPreferredGender extends ConsumerWidget {
  const SelectPreferredGender({super.key});

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
      appBar: CustomAppBar(title: AppStrings.genderPreferenceTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 25.h),
                      CustomText(
                        text: AppStrings.lookingForText,
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
                          AppStrings.openToAll,
                        ],
                        onCircleSelected: (index) {
                          // Update the preferred gender in the state
                          final preferredGender = [
                            AppStrings.female,
                            AppStrings.male,
                            AppStrings.nonBinary,
                            AppStrings.transgender,
                            AppStrings.genderFluid,
                            AppStrings.openToAll,
                          ][index];
                          userNotifier.updatePreferredGender(preferredGender);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(userProvider);
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      color: AppColors.background,
                      child: Center(
                        child: CustomRoundButton(
                          text: state?.isLoading == true
                              ? AppStrings.saving
                              : AppStrings.continueButton,
                          onPressed: state?.isLoading == true
                              ? null
                              : () {
                            if (state?.user.preferences.gender == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please select your preferred gender'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            logger.i(state?.user.preferences.gender);
                            context.go(RouterPath.selectBodyType);
                          },
                        ),
                      ),
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