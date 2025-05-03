import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/connection_pathway_providers.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionPathway extends ConsumerStatefulWidget {
  const ConnectionPathway({super.key});

  @override
  ConsumerState<ConnectionPathway> createState() =>
      _ConnectionPathwayPageState();
}

class _ConnectionPathwayPageState extends ConsumerState<ConnectionPathway> {
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

  bool get isFormComplete {
    return _boundariesValue != null &&
        _consentValue != null &&
        _monogamousValue != null &&
        _exclusivityReasonController.text.isNotEmpty &&
        _emotionalAvailabilityValue != null &&
        _resolvedBaggageValue != null &&
        _committedValue != null &&
        _selfWorkValue != null &&
        _deepConversationValue != null &&
        _strongRelationshipValue != null;
  }

  void submitForm() async {
    if (ref.read(connectionPathwayProvider).isSuccess == true &&
        ref.read(connectionPathwayProvider).isLoading == false) {}
  }

  @override
  Widget build(BuildContext context) {
    final connectionState = ref.watch(connectionPathwayProvider);
    final connectionNotifier = ref.read(connectionPathwayProvider.notifier);

    ref.listen(connectionPathwayProvider, (prev, current) async {
      if (current.isLoading == false && current.isSuccess == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstTime', false);
        context.push(RouterPath.signUp);
      } else if(current.isLoading == false && current.isSuccess == false) {
        context.push(RouterPath.attention);
      }
    });

    return Scaffold(
      appBar:
          CustomAppBar(title: AppStrings.connectionPathway, isLeading: true),
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
                _buildQuestion(
                  text:
                      "I believe in communicating openly about boundaries with my partner.",
                  groupValue: _boundariesValue,
                  onChanged: (value) =>
                      setState(() => _boundariesValue = value),
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree'
                  ],
                ),
                _buildQuestion(
                  text:
                      "It’s important to me that both partners give enthusiastic consent before progressing to physical intimacy.",
                  groupValue: _consentValue,
                  onChanged: (value) => setState(() => _consentValue = value),
                  labels: ['Yes', 'No'],
                ),
                _buildQuestion(
                  text:
                      "I am interested in a monogamous, exclusive relationship.",
                  groupValue: _monogamousValue,
                  onChanged: (value) =>
                      setState(() => _monogamousValue = value),
                  labels: ['Yes', 'No', 'Not sure yet'],
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label:
                      'Why is exclusivity important to you in a relationship?',
                  hint: 'Details',
                  controller: _exclusivityReasonController,
                  maxLines: 1,
                  onChanged: (value) => setState(() {}),
                ),
                _buildQuestion(
                  text:
                      "I am emotionally available and ready to invest in a serious relationship.",
                  groupValue: _emotionalAvailabilityValue,
                  onChanged: (value) =>
                      setState(() => _emotionalAvailabilityValue = value),
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree'
                  ],
                ),
                _buildQuestion(
                  text:
                      "I have resolved most of my past relationship baggage and am ready to move forward.",
                  groupValue: _resolvedBaggageValue,
                  onChanged: (value) =>
                      setState(() => _resolvedBaggageValue = value),
                  labels: ['Yes', 'No'],
                ),
                _buildQuestion(
                  text: "I prioritize being in a committed relationship.",
                  groupValue: _committedValue,
                  onChanged: (value) => setState(() => _committedValue = value),
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree'
                  ],
                ),
                _buildQuestion(
                  text:
                      "Have you worked on yourself to become a better partner?",
                  groupValue: _selfWorkValue,
                  onChanged: (value) => setState(() => _selfWorkValue = value),
                  labels: ['Yes', 'No', 'Not sure yet'],
                ),
                _buildQuestion(
                  text:
                      "I am willing to invest time in deep conversations to truly understand my partner.",
                  groupValue: _deepConversationValue,
                  onChanged: (value) =>
                      setState(() => _deepConversationValue = value),
                  labels: ['Yes', 'No'],
                ),
                _buildQuestion(
                  text:
                      "I believe that building a strong relationship takes time and intentional effort.",
                  groupValue: _strongRelationshipValue,
                  onChanged: (value) =>
                      setState(() => _strongRelationshipValue = value),
                  labels: [
                    'Strongly Disagree',
                    'Disagree',
                    'Neutral',
                    'Agree',
                    'Strongly Agree'
                  ],
                ),
                SizedBox(height: 30.h),
                // CustomRoundButton(text: AppStrings.submit, onPressed: () => context.push(RouterPath.signUp),)
                CustomRoundButton(
                  text: connectionState.isLoading == true
                      ? "Submitting"
                      : AppStrings.submit,
                  onPressed: connectionState.isLoading == true
                      ? null
                      : () async {
                          if (isFormComplete) {
                            List<String> answers = [
                              _boundariesValue!,
                              _consentValue!,
                              _monogamousValue!,
                              _exclusivityReasonController.text.trim(),
                              _emotionalAvailabilityValue!,
                              _resolvedBaggageValue!,
                              _committedValue!,
                              _selfWorkValue!,
                              _deepConversationValue!,
                              _strongRelationshipValue!,
                            ];
                            await connectionNotifier.isSuitable(answers);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Answer All Questions',
                                  message:
                                      "Please answer all questions before proceeding",
                                  contentType: ContentType.failure,
                                ),
                              ),
                            );
                          }
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion({
    required String text,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
    required List<String> labels,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(text, style: TextStyle(fontSize: 14.sp)),
        SizedBox(height: 8.h),
        Column(
          children: labels.map((label) {
            return Row(
              children: [
                Transform.scale(
                  scale: 1.4,
                  child: Radio<String>(
                    value: label,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    activeColor: AppColors.accent,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: CustomText(
                      text: label,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
