import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SelectAge extends ConsumerStatefulWidget {
  const SelectAge({super.key});

  @override
  ConsumerState<SelectAge> createState() => _SelectAgeState();
}

class _SelectAgeState extends ConsumerState<SelectAge> {
  DateTime? selectedDate;

  // Calculate age from DateTime (for display and validation only)
  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _selectDate() async {
    setState(() {
      selectedDate = null;
    });
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 35)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryText, // "OK" and "Cancel" button color
              onPrimary: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryText,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final age = _calculateAge(pickedDate);
      if (age < 35) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Age Restriction",
              message: "Sorry! But you are not eligible for the app.",
              contentType: ContentType.failure,
            ),
          ),
        );
      } else {
        setState(() {
          selectedDate = pickedDate;
        });
        // Format the date to "dd/MM/yyyy"
        final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        ref.read(userProvider.notifier).updateDateOfBirth(formattedDate);
        logger.i("Selected date of birth: $formattedDate, Age: $age");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
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
      appBar: CustomAppBar(title: AppStrings.selectAgeTitle, isLeading: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w)
              .copyWith(top: 20.h, bottom: 44.h),
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
                        text: AppStrings.howOldAreYou,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        text: "Please choose your date of birth",
                        color: AppColors.primaryText,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      // Date Picker Section
                      OutlinedButton(
                        onPressed: _selectDate,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryText,
                          side: BorderSide(color: AppColors.accent),
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        ),
                        child: CustomText(
                          text: 'Select Your Date of Birth',
                          color: AppColors.primaryText,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomText(
                        text: selectedDate != null
                            ? 'Selected Date of Birth: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} (Age: ${_calculateAge(selectedDate!)})'
                            : 'No date selected',
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
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
                        if (selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: "Selection Required",
                                message: "Please select your date of birth",
                                contentType: ContentType.warning,
                              ),
                            ),
                          );
                          return;
                        }
                        logger.i(ref.watch(userProvider)!.user.dateOfBirth);
                        context.push(RouterPath.selectPreferredAge);
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