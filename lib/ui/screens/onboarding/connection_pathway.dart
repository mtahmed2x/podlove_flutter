import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class ConnectionPathway extends StatefulWidget {
  const ConnectionPathway({super.key});

  @override
  State<ConnectionPathway> createState() => _ConnectionPathwayPageState();
}

class _ConnectionPathwayPageState extends State<ConnectionPathway> {
  String? _boundariesValue;
  String? _consentValue;
  String? _monogamousValue;
  String? _emotionalAvailabilityValue;
  String? _resolvedBaggageValue;
  String? _committedValue;
  String? _selfWorkValue;
  String? _deepConversationValue;
  String? _strongRelationshipValue;

  final TextEditingController _exclusivityReasonController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.connectionPathway, isLeading: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                CustomText(
                  text: 'Please Fill out this form',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),

                SizedBox(height: 16.h),
                Text(
                  'I believe in communicating openly about boundaries with my partner.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _boundariesValue,
                  onChanged: (value) {
                    setState(() => _boundariesValue = value);
                  },
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree',
                  ],
                ),

                SizedBox(height: 16.h),
                Text(
                  'It’s important to me that both partners give enthusiastic consent before progressing to physical intimacy.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _consentValue,
                  onChanged: (value) {
                    setState(() => _consentValue = value);
                  },
                  labels: ['Yes', 'No'],
                ),

                SizedBox(height: 16.h),
                Text(
                  'I am interested in a monogamous, exclusive relationship.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _monogamousValue,
                  onChanged: (value) {
                    setState(() => _monogamousValue = value);
                  },
                  labels: ['Yes', 'No', 'Not sure yet'],
                ),

                SizedBox(height: 16.h),
                CustomTextField(
                  label:
                      'Why is exclusivity important to you in a relationship?',
                  hint: 'Details',
                  controller: _exclusivityReasonController,
                  maxLines: 1,
                ),

                SizedBox(height: 16.h),
                Text(
                  'I am emotionally available and ready to invest in a serious relationship.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _emotionalAvailabilityValue,
                  onChanged: (value) {
                    setState(() => _emotionalAvailabilityValue = value);
                  },
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree'
                  ],
                ),

                SizedBox(height: 16.h),
                Text(
                  'I have resolved most of my past relationship baggage and am ready to move forward.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _resolvedBaggageValue,
                  onChanged: (value) {
                    setState(() => _resolvedBaggageValue = value);
                  },
                  labels: ['Yes', 'No'],
                ),

                SizedBox(height: 16.h),
                Text(
                  'I prioritize being in a committed relationship.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _committedValue,
                  onChanged: (value) {
                    setState(() => _committedValue = value);
                  },
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree',
                  ],
                ),

                SizedBox(height: 16.h),
                Text(
                  'Have you worked on yourself to become a better partner? ',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _selfWorkValue,
                  onChanged: (value) {
                    setState(() => _selfWorkValue = value);
                  },
                  labels: ['Yes', 'No', 'Not sure yet'],
                ),

                SizedBox(height: 16.h),
                Text(
                  'I am willing to invest time in deep conversations to truly understand my partner. ',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _deepConversationValue,
                  onChanged: (value) {
                    setState(() => _deepConversationValue = value);
                  },
                  labels: ['Yes', 'No'],
                ),

                SizedBox(height: 16.h),
                Text(
                  'I believe that building a strong relationship takes time and intentional effort.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                _buildRadioGroup<String>(
                  groupValue: _strongRelationshipValue,
                  onChanged: (value) {
                    setState(() => _strongRelationshipValue = value);
                  },
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree',
                  ],
                ),
                SizedBox(height: 30.h),

                CustomRoundButton(
                  text: AppStrings.submit,
                  onPressed: () {
                    context.push(RouterPath.attention);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioGroup<T>({
    required T? groupValue,
    required ValueChanged<T?> onChanged,
    required List<String> labels,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: labels.map((label) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.4,
              child: Radio<T>(
                value: label as T,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: AppColors.accent,
                fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.accent;
                  }
                  return AppColors.accent;
                }),
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: CustomText(
                text: label,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
