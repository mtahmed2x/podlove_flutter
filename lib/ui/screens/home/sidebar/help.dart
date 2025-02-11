import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/help_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class Help extends ConsumerStatefulWidget {
  const Help({super.key});

  @override
  ConsumerState<Help> createState() => _HelpState();
}

class _HelpState extends ConsumerState<Help> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory; // To store the selected category

  // List of categories
  final List<String> _categories = [
    'Technical',
    'Billing',
    'Account',
    'General Inquiry',
  ];

  @override
  Widget build(BuildContext context) {
    final helpState = ref.watch(helpProvider);
    final helpNotifier = ref.read(helpProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(title: "Help Center", isLeading: true,),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(
            top: 30.h,
            bottom: 44.h,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: "Message Us",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 50.h),

                // Dropdown for selecting issue category
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                      fillColor: Colors.white, // Set the background color (e.g., white)
                      filled: true,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppColors.accent,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppColors.accent,
                        width: 1.0,
                      ),
                    ),
                    labelText: 'Select Category',
                    labelStyle: TextStyle(color: AppColors.primaryText, fontSize: 14.sp)
                  ),
                  items: _categories
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "",
                  hint: "Enter your description here",
                  maxLines: 5,
                  controller: helpNotifier.issueController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterPhoneNumberError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: helpState.isLoading ? "Submitting..." : "Submit",
                  onPressed: helpState.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            helpNotifier.submitHelp(
                                _selectedCategory!); // Passing the selected category
                            helpNotifier.issueController.text = "";
                          }
                        },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
