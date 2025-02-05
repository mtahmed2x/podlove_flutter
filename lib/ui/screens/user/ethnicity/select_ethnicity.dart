import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SelectEthnicity extends ConsumerStatefulWidget {
  const SelectEthnicity({super.key});

  @override
  ConsumerState<SelectEthnicity> createState() => _SelectEthnicityState();
}

class _SelectEthnicityState extends ConsumerState<SelectEthnicity> {
  final List<String> ethnicityOptions = [
    "African American/Black",
    "Asian",
    "Caucasian/White",
    "Hispanic/Latino",
    "Middle Eastern",
    "Native American",
    "Pacific Islander",
    "Other"
  ];

  String? selectedEthnicity;

  void selectEthnicity(String ethnicity) {
    setState(() {
      selectedEthnicity = ethnicity;
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
      appBar: CustomAppBar(title: "Ethnicity"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 30.h, bottom: 44.h),
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
                        text: "What is your ethnicity?",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                CustomText(
                  text: "Please select at least one",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 15.h),
                CustomCheckboxGroup(
                  labels: ethnicityOptions,
                  selectedItem: selectedEthnicity,
                  onItemSelected: selectEthnicity,
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: userState?.isLoading == true ? "Saving" : "Continue",
                  onPressed: userState?.isLoading == true
                      ? null
                      : () {
                          if (selectedEthnicity == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select your ethnicity'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          userNotifier.updateEthnicity(selectedEthnicity!);
                          logger.i(selectedEthnicity);
                          context.push(RouterPath.selectPreferredEthnicities);
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

class CustomCheckboxGroup extends StatelessWidget {
  final List<String> labels;
  final String? selectedItem;
  final Function(String) onItemSelected;

  const CustomCheckboxGroup({
    super.key,
    required this.labels,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: labels.map((label) {
        return GestureDetector(
          onTap: () => onItemSelected(label),
          child: Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                ),
                side: WidgetStateBorderSide.resolveWith(
                      (states) => BorderSide(width: 2.0.w, color: AppColors.accent),
                ),
                value: selectedItem == label,
                activeColor: AppColors.accent,
                checkColor: AppColors.background,
                onChanged: (value) => onItemSelected(label),
              ),
              Expanded(
                child: CustomText(
                  text: label,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
