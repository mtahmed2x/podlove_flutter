import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SelectPreferredAge extends ConsumerWidget {
  const SelectPreferredAge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final preferences = userState?.user.preferences;
    final initialMin = preferences?.age.min ?? 35;
    final initialMax = preferences?.age.max ?? 55;
    final error = userState?.error;
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      });
    }
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.ageRangeTitle),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      Center(
                        child: Column(
                          children: [
                            AppWidgets.podLoveLogo,
                            SizedBox(height: 30.h),
                            CustomText(
                              text: AppStrings.ageRangeQuestion,
                              color: AppColors.primaryText,
                              fontSize: 22.sp,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 40.h),
                            _AgeRangeDropdown(
                              minInitialAge: initialMin,
                              maxInitialAge: initialMax,
                              onAgeChanged: (min, max) {
                                ref
                                    .read(userProvider.notifier)
                                    .updatePreferencesAgeRange(min, max);
                              },
                            ),
                            SizedBox(height: 50.h),
                            Consumer(builder: (context, ref, _) {
                              final state = ref.watch(userProvider);
                              return CustomRoundButton(
                                text: state?.isLoading == true
                                    ? AppStrings.saving
                                    : AppStrings.continueButton,
                                onPressed: state?.isLoading == true
                                    ? null
                                    : () {
                                        final prefs =
                                            state?.user.preferences.age;
                                        if (prefs?.min == null ||
                                            prefs?.max == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Please select valid age range'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        logger.i(state?.user.age);
                                        logger.i(state?.user);
                                        logger.i(state?.user.location.place);
                                        logger.i(state?.user.location.latitude);
                                        context.go(RouterPath.selectGender);
                                      },
                              );
                            }),
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
      ),
    );
  }
}

class _AgeRangeDropdown extends StatefulWidget {
  final int minInitialAge;
  final int maxInitialAge;
  final Function(int minAge, int maxAge)? onAgeChanged;

  const _AgeRangeDropdown({
    required this.minInitialAge,
    required this.maxInitialAge,
    this.onAgeChanged,
  });

  @override
  State<_AgeRangeDropdown> createState() => _AgeRangeDropdownState();
}

class _AgeRangeDropdownState extends State<_AgeRangeDropdown> {
  late int _minAge;
  late int _maxAge;
  final List<int> _ageOptions = List.generate(21, (index) => 35 + index);

  @override
  void initState() {
    super.initState();
    _minAge = widget.minInitialAge < 35 ? 35 : widget.minInitialAge;
    _maxAge = widget.maxInitialAge < 36 ? 36 : widget.maxInitialAge;
    if (_minAge > 55) _minAge = 55;
    if (_maxAge > 55) _maxAge = 55;
    if (_maxAge <= _minAge) _maxAge = _minAge + 1 <= 55 ? _minAge + 1 : 55;
  }

  @override
  void didUpdateWidget(covariant _AgeRangeDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.minInitialAge != _minAge) {
      _minAge = widget.minInitialAge < 35 ? 35 : widget.minInitialAge;
    }
    if (widget.maxInitialAge != _maxAge) {
      _maxAge = widget.maxInitialAge < 36 ? 36 : widget.maxInitialAge;
    }
    if (_minAge > 55) _minAge = 55;
    if (_maxAge > 55) _maxAge = 55;
    if (_maxAge <= _minAge) _maxAge = _minAge + 1 <= 55 ? _minAge + 1 : 55;
  }

  void _updateAges({int? minAge, int? maxAge}) {
    setState(() {
      if (minAge != null) {
        if (minAge! < 35) minAge = 35;
        if (minAge! > 55) minAge = 55;
        _minAge = minAge!;
        if (_maxAge <= _minAge) {
          _maxAge = _minAge + 1 <= 55 ? _minAge + 1 : 55;
        }
      }
      if (maxAge != null) {
        if (maxAge! < 36) maxAge = 36;
        if (maxAge! > 55) maxAge = 55;
        if (maxAge! <= _minAge) maxAge = _minAge + 1 <= 55 ? _minAge + 1 : 55;
        _maxAge = maxAge!;
      }
    });
    widget.onAgeChanged?.call(_minAge, _maxAge);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AgeDropdown(
          value: _minAge,
          label: AppStrings.minimumAge,
          items: _ageOptions.where((age) =>
              age >= 35 && age < _maxAge), // Ensure minimum age starts at 35
          onChanged: (value) => _updateAges(minAge: value),
        ),
        SizedBox(width: 40.w),
        _AgeDropdown(
          value: _maxAge,
          label: AppStrings.maximumAge,
          items: _ageOptions.where((age) =>
              age > _minAge &&
              age <= 55), // Ensure maximum age is above minimum and <= 55
          onChanged: (value) => _updateAges(maxAge: value),
        ),
      ],
    );
  }
}

class _AgeDropdown extends StatelessWidget {
  final int value;
  final String label;
  final Iterable<int> items;
  final ValueChanged<int> onChanged;

  const _AgeDropdown({
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 130.w,
          child: DropdownButtonFormField<int>(
            value: value,
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
            items: items
                .map((age) => DropdownMenuItem(
                      value: age,
                      child: Text("$age"),
                    ))
                .toList(),
            onChanged: (value) => value != null ? onChanged(value) : null,
          ),
        ),
      ],
    );
  }
}
