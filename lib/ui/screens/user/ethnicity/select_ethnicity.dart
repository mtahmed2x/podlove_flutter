import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_check_box.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SelectEthnicity extends ConsumerWidget {
  const SelectEthnicity({super.key});

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
      appBar: CustomAppBar(title: "Ethnicity"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 25.h),
                      CustomText(
                        text: "What is your ethnicity?",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Please select at least one",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "African American/Black ",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier
                              .updateEthnicity("African American/Black");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Asian",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updateEthnicity("Asian");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Caucasian/White",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updateEthnicity("Caucasian/White");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Hispanic/Latino",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updateEthnicity("Hispanic/Latino");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Middle Eastern",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updateEthnicity("Middle Eastern");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Native American",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updateEthnicity("Native American");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Pacific Islander",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updateEthnicity("Pacific Islander");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Other",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updateEthnicity("Other");
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(userProvider);
                    return CustomRoundButton(
                      text: state?.isLoading == true ? "Saving" : "Continue",
                      onPressed: state?.isLoading == true
                          ? null
                          : () {
                              if (state?.user.ethnicity == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please select your ethnicity'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              logger.i(state?.user.ethnicity);
                              context.go(RouterPath
                                  .selectPreferredEthnicities); // Navigate to the next screen
                            },
                    );
                  },
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
