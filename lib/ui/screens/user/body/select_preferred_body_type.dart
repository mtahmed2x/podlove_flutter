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

class SelectPreferredBodyType extends ConsumerWidget {
  const SelectPreferredBodyType({super.key});

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
      appBar: CustomAppBar(title: "Preferred Body Type"),
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
                        text: "What body type are you looking for?",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 20.h),
                      CustomText(
                        text:
                            "Choose the option that best represents your preference",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
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
                      text: "Please select one",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Athletic",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updatePreferredBodyType("Athletic");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Curvy",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updatePreferredBodyType("Curvy");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Slim",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updatePreferredBodyType("Slim");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Average",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updatePreferredBodyType("Average");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Plus-size",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updatePreferredBodyType("Plus-size");
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomCheckbox(
                      label: "Muscular",
                      labelFontSize: 18.sp,
                      labelFontWeight: FontWeight.w400,
                      onChanged: (value) {
                        if (value == true) {
                          userNotifier.updatePreferredBodyType("Muscular");
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 60.h),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(userProvider);
                    return CustomRoundButton(
                      text: state?.isLoading == true ? "Saving" : "Continue",
                      onPressed: state?.isLoading == true
                          ? null
                          : () {
                              if (state?.user.preferences.bodyType == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please select your preferred body type'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              logger.i(state?.user.preferences.bodyType);
                              context.go(RouterPath
                                  .selectEthnicity); // Navigate to the next screen
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
