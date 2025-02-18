import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/dynamic_range_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/utils/logger.dart';

class DistancePreference extends ConsumerWidget {
  const DistancePreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(title: "Distance Preferences", isLeading: true,),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
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
                        text: "Set Your Distance",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      CustomText(
                        text: "Preferences",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                DynamicRangeSlider(
                  min: 1,
                  max: 100,
                  initialValue: 30,
                  unit: "Miles",
                  onChanged: (value) {
                    logger.i(value);
                    userNotifier.updateDistancePreference(value.toInt());
                    logger.i(userState?.user.location.latitude);
                    logger.i(userState?.user.preferences.distance);
                  },
                ),
                SizedBox(height: 80.h),
                Consumer(
                  builder: (context, ref, _) {
                    final currentState = ref.watch(userProvider);
                    return CustomRoundButton(
                      text: "Continue",
                      onPressed: () {
                        if (currentState?.user.preferences.distance != null) {
                          context.push(RouterPath.selectAge);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please set a distance preference'),
                            ),
                          );
                        }
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
