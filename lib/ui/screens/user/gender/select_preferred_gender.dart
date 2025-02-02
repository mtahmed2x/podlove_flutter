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

class SelectPreferredGender extends ConsumerStatefulWidget {
  const SelectPreferredGender({super.key});

  @override
  ConsumerState<SelectPreferredGender> createState() =>
      _SelectPreferredGenderState();
}

class _SelectPreferredGenderState extends ConsumerState<SelectPreferredGender> {
  final List<String> genderOptions = [
    AppStrings.female,
    AppStrings.male,
    AppStrings.nonBinary,
    AppStrings.transgender,
    AppStrings.genderFluid,
    AppStrings.openToAll,
  ];

  List<String> selectedGenders = [];

  void toggleSelection(String gender) {
    setState(() {
      if (selectedGenders.contains(gender)) {
        selectedGenders.remove(gender);
      } else {
        selectedGenders.add(gender);
      }
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
      appBar: CustomAppBar(title: AppStrings.genderPreferenceTitle),
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
                        text: AppStrings.lookingForText,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 40.h),
                      SelectableCircleGroup(
                        labels: genderOptions,
                        selectedItems: selectedGenders,
                        onSelectionChanged: (selected) {
                          setState(() {
                            selectedGenders = selected;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
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
                              if (selectedGenders.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please select at least one preferred gender'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              userNotifier
                                  .updatePreferredGender(selectedGenders);
                              logger.i(selectedGenders);
                              context.push(RouterPath.selectBodyType);
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

class SelectableCircleGroup extends StatelessWidget {
  final List<String> labels;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;

  const SelectableCircleGroup({
    super.key,
    required this.labels,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      alignment: WrapAlignment.center,
      children: labels.map((label) {
        final isActive = selectedItems.contains(label);
        return GestureDetector(
          onTap: () {
            List<String> updatedSelection = List.from(selectedItems);
            if (isActive) {
              updatedSelection.remove(label);
            } else {
              updatedSelection.add(label);
            }
            onSelectionChanged(updatedSelection);
          },
          child: Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color.fromARGB(255, 0, 0, 255)
                  : const Color.fromRGBO(255, 161, 117, 1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
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
