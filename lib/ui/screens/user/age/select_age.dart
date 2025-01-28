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
import 'package:podlove_flutter/ui/widgets/custom_number_picker.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SelectAge extends ConsumerWidget {
  const SelectAge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);
    final age = userState?.user.age ?? 35;
    final error = userState?.error;

    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      });
    }

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.selectAgeTitle),
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
                        text: AppStrings.howOldAreYou,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: AppStrings.ageDescription,
                        color: AppColors.primaryText,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      CustomNumberPicker(
                        start: 35,
                        end: 55,
                        initialValue: 42,
                        onNumberSelected: (value) {
                          logger.i("old age: $age");
                          userNotifier.updateAge(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Consumer(builder: (context, ref, _) {
                  final state = ref.watch(userProvider);
                  return CustomRoundButton(
                    text: state?.isLoading == true
                        ? AppStrings.saving
                        : AppStrings.continueButton,
                    onPressed: state?.isLoading == true
                        ? null
                        : () {
                            if (state?.user.age == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select your age'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            logger.i("new age: $age");
                            context.go(RouterPath.selectPreferredAge);
                          },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
