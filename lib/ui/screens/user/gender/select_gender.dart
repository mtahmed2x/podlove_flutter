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
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SelectGender extends ConsumerStatefulWidget {
  const SelectGender({super.key});

  @override
  ConsumerState<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends ConsumerState<SelectGender> {
  final List<String> genderOptions = [
    AppStrings.female,
    AppStrings.male,
    AppStrings.nonBinary,
    AppStrings.transgender,
    AppStrings.genderFluid,
  ];

  String? selectedGender;

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: CustomAppBar(title: AppStrings.selectGenderTitle, isLeading: true,),
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
                      SizedBox(height: 25.h),
                      CustomText(
                        text: AppStrings.genderQuestion,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 40.h),
                      GenderSelectionGroup(
                        labels: genderOptions,
                        selectedGender: selectedGender,
                        onGenderSelected: selectGender,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                CustomRoundButton(
                  text: userState?.isLoading == true
                      ? AppStrings.saving
                      : AppStrings.continueButton,
                  onPressed: userState?.isLoading == true
                      ? null
                      : () {
                          if (selectedGender == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select your gender'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          userNotifier.updateGender(selectedGender!);
                          logger.i(selectedGender);
                          context.push(RouterPath.selectPreferredGender);
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

class GenderSelectionGroup extends StatelessWidget {
  final List<String> labels;
  final String? selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelectionGroup({
    super.key,
    required this.labels,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0.h,
      children: labels.map((label) {
        final isActive = selectedGender == label;
        return GestureDetector(
          onTap: () => onGenderSelected(label),
          child: Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 161, 117, 1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                color: isActive ? AppColors.blue : AppColors.background,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}
