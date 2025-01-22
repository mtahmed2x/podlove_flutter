import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class SelectPreferredAge extends StatelessWidget {
  const SelectPreferredAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.ageRangeTitle),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),
                    Center(
                      child: Column(
                        children: [
                          // Logo
                          AppWidgets.podLoveLogo,
                          SizedBox(height: 25.h),
                          CustomText(
                            text: AppStrings.ageRangeQuestion,
                            color: AppColors.primaryText,
                            fontSize: 22.sp,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 40.h),
                          _AgeRangeDropdown(
                            minInitialAge: 30,
                            maxInitialAge: 50,
                            onAgeChanged: (int minAge, int maxAge) {
                              // Handle age change
                            },
                          ),
                          SizedBox(height: 100.h),
                          CustomRoundButton(
                            text: AppStrings.continueButton,
                            onPressed: () {
                              // Handle continue action
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AgeRangeDropdown extends StatefulWidget {
  final int minInitialAge;
  final int maxInitialAge;
  final Function(int minAge, int maxAge)? onAgeChanged;

  const _AgeRangeDropdown({
    this.minInitialAge = 18,
    this.maxInitialAge = 60,
    this.onAgeChanged,
  });

  @override
  State<_AgeRangeDropdown> createState() => _AgeRangeDropdownState();
}

class _AgeRangeDropdownState extends State<_AgeRangeDropdown> {
  late int _minAge;
  late int _maxAge;

  final List<int> _ageOptions = List.generate(66, (index) => 18 + index);

  @override
  void initState() {
    super.initState();
    _minAge = widget.minInitialAge;
    _maxAge = widget.maxInitialAge;
  }

  void _updateAges({int? minAge, int? maxAge}) {
    setState(() {
      if (minAge != null) {
        _minAge = minAge;
        if (_maxAge <= _minAge) {
          _maxAge = _minAge + 1;
        }
      }
      if (maxAge != null && maxAge > _minAge) {
        _maxAge = maxAge;
      }
    });

    // Notify the parent widget
    if (widget.onAgeChanged != null) {
      widget.onAgeChanged!(_minAge, _maxAge);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: AppStrings.minimumAge,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 130.w,
              child: DropdownButtonFormField<int>(
                value: _minAge,
                onChanged: (int? newValue) => _updateAges(minAge: newValue),
                items: _ageOptions
                    .map((age) => DropdownMenuItem<int>(
                          value: age,
                          child: Text("$age"),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.accent,
                      width: 0.8.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.accent,
                      width: 1.0.w,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 100.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              text: AppStrings.maximumAge,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 130.w,
              child: DropdownButtonFormField<int>(
                value: _maxAge,
                onChanged: (int? newValue) => _updateAges(maxAge: newValue),
                items: _ageOptions
                    .where((age) => age > _minAge)
                    .map((age) => DropdownMenuItem<int>(
                          value: age,
                          child: Text("$age"),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.accent,
                      width: 0.8.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.accent,
                      width: 1.0.w,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
