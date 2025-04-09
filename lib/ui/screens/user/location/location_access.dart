import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class LocationAccess extends ConsumerWidget {
  const LocationAccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.read(userProvider.notifier);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.locationAccessTitle),
        backgroundColor: AppColors.backgroundAlt,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Center(
                    child: Column(
                      children: [
                        AppWidgets.podLoveLogo,
                        SizedBox(height: 50.h),
                        Image.asset(
                          AppStrings.locationImagePath,
                          width: 170.w,
                          height: 130.h,
                        ),
                        SizedBox(height: 40.h),
                        CustomText(
                          text: AppStrings.enableLocationHeader,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 15.h),
                        CustomText(
                          text: AppStrings.enableLocationDescription,
                          fontSize: 14.sp,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 50.h),
                        CustomRoundButton(
                          text: AppStrings.allowLocationAccessButton,
                          onPressed: () async {
                            final success =
                                await userNotifier.getCurrentLocation();
                            if (context.mounted) {
                              if (success) {
                                GoRouter.of(context)
                                    .push(RouterPath.distancePreference);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Failed to get location')),
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () => GoRouter.of(context).push(RouterPath.enterLocation),
                          child: CustomText(
                            text: "Enter Location Manually",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
