import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  /// Store selected radio answers here (index-based, e.g., 0,1,2,...).
  /// If the user hasn't selected anything, it remains `null`.
  int? _overallConnection;
  int? _comfortableWithMatch;
  int? _chemistry;
  int? _aiAccuracy;
  int? _similarValues;
  int? _communicationQuality;
  int? _comfortableBeingSelf;
  int? _overallSatisfaction;
  int? _seeMatchAgain;
  int? _easeOfUse;
  int? _duplicateYesNo; // For the repeated question example

  final TextEditingController _matchDescriptionController =
  TextEditingController();
  final TextEditingController _chemistryFactorsController =
  TextEditingController();
  final TextEditingController _awkwardMomentsController =
  TextEditingController();
  final TextEditingController _decisionReasonController =
  TextEditingController();
  final TextEditingController _someTextFieldController =
  TextEditingController();
  final TextEditingController _improvementsController =
  TextEditingController();
  final TextEditingController _futureDatesController =
  TextEditingController();
  final TextEditingController _optionalFeedbackController =
  TextEditingController();

  @override
  void dispose() {
    /// Don’t forget to dispose of controllers
    _matchDescriptionController.dispose();
    _chemistryFactorsController.dispose();
    _awkwardMomentsController.dispose();
    _decisionReasonController.dispose();
    _someTextFieldController.dispose();
    _improvementsController.dispose();
    _futureDatesController.dispose();
    _optionalFeedbackController.dispose();
    super.dispose();
  }

  /// Call this when user presses the "Continue" button
  void _validateAndSubmit() {
    // Simple checks:
    // 1. Make sure all required radio questions are answered (not null).
    // 2. Make sure required text fields are non-empty.

    if (_overallConnection == null ||
        _comfortableWithMatch == null ||
        _chemistry == null ||
        _aiAccuracy == null ||
        _similarValues == null ||
        _communicationQuality == null ||
        _comfortableBeingSelf == null ||
        _overallSatisfaction == null ||
        _seeMatchAgain == null ||
        _easeOfUse == null ||
        _duplicateYesNo == null ||
        _matchDescriptionController.text.trim().isEmpty ||
        _chemistryFactorsController.text.trim().isEmpty ||
        _awkwardMomentsController.text.trim().isEmpty
    // etc... (Add other required text fields if they're mandatory)
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: SizedBox(
            width: 400,
            child: AwesomeSnackbarContent(
              title: "Fill All Fields",
              message: "Please fill all required fields before continuing.",
              contentType: ContentType.failure,
            ),
          ),
        ),
      );
    } else {
      // If everything is filled out, show the success dialog.
      _showSuccessDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: " Post-Date Feedback",
        isLeading: true,
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const CustomText(
                  text:
                  "Thank you for joining our Pod! Your feedback is crucial in helping us improve the PodLove experience for you and others. Please take a few moments to share your thoughts.",
                  color: Color.fromARGB(255, 39, 87, 166),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                /// 1. Overall Connection
                const CustomText(
                  text: "1. Overall Connection",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                QuestionWidget(
                  question:
                  "How would you rate your overall connection with your date? *",
                  options: [
                    "1 (No connection at all)",
                    "2",
                    "3",
                    "4",
                    "5 (Strong connection)"
                  ],
                  onChanged: (selected) => setState(() {
                    _overallConnection = selected;
                  }),
                ),
                const SizedBox(height: 10),
                QuestionWidget(
                  question:
                  "Did you feel comfortable with your match during the date? *",
                  options: [
                    "Yes",
                    "Somewhat",
                    "No",
                  ],
                  onChanged: (selected) => setState(() {
                    _comfortableWithMatch = selected;
                  }),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                  "Please describe what stood out to you about your match (positive or negative).",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _matchDescriptionController,
                ),

                /// 2. Chemistry and Compatibility
                const SizedBox(height: 20),
                const CustomText(
                  text: "2. Chemistry and Compatibility",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                QuestionWidget(
                  question:
                  "How would you rate the chemistry you felt with your match? *",
                  options: [
                    "1 (No chemistry at all)",
                    "2",
                    "3",
                    "4",
                    "5 (Strong chemistry)"
                  ],
                  onChanged: (selected) => setState(() {
                    _chemistry = selected;
                  }),
                ),
                const SizedBox(height: 10),
                QuestionWidget(
                  question:
                  "Do you feel that the AI matchmaking captured your preferences accurately? *",
                  options: [
                    "Yes",
                    "Somewhat",
                    "No",
                  ],
                  onChanged: (selected) => setState(() {
                    _aiAccuracy = selected;
                  }),
                ),
                const SizedBox(height: 10),
                QuestionWidget(
                  question:
                  "Did you and your match share similar values, interests, or relationship goals? *",
                  options: [
                    "Yes",
                    "Somewhat",
                    "No",
                  ],
                  onChanged: (selected) => setState(() {
                    _similarValues = selected;
                  }),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                  "In your opinion, what factors influenced the level of chemistry you experienced?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _chemistryFactorsController,
                ),

                /// 3. Communication and Comfort
                const SizedBox(height: 20),
                const CustomText(
                  text: "3. Communication and Comfort",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                QuestionWidget(
                  question:
                  "How would you rate the quality of communication during the date? *",
                  options: [
                    "1 (No connection at all)",
                    "2",
                    "3",
                    "4",
                    "5 (Strong connection)"
                  ],
                  onChanged: (selected) => setState(() {
                    _communicationQuality = selected;
                  }),
                ),
                const SizedBox(height: 10),
                QuestionWidget(
                  question:
                  "Did you feel comfortable being yourself during the date? *",
                  options: [
                    "Yes",
                    "Somewhat",
                    "No",
                  ],
                  onChanged: (selected) => setState(() {
                    _comfortableBeingSelf = selected;
                  }),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                  "Were there any awkward or uncomfortable moments? If so, please describe. *",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _awkwardMomentsController,
                ),

                /// 4. Date Satisfaction
                const SizedBox(height: 20),
                const CustomText(
                  text: "4. Date Satisfaction",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                QuestionWidget(
                  question:
                  "How satisfied were you with the overall experience? *",
                  options: [
                    "1 (No connection at all)",
                    "2",
                    "3",
                    "4",
                    "5 (Strong connection)"
                  ],
                  onChanged: (selected) => setState(() {
                    _overallSatisfaction = selected;
                  }),
                ),
                const SizedBox(height: 10),
                QuestionWidget(
                  question:
                  "Would you be interested in seeing your match again? *",
                  options: [
                    "Yes",
                    "Somewhat",
                    "No",
                  ],
                  onChanged: (selected) => setState(() {
                    _seeMatchAgain = selected;
                  }),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "If not, can you share what led to this decision?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _decisionReasonController,
                ),

                /// 5. App Experience
                const SizedBox(height: 20),
                const CustomText(
                  text: "5. App Experience",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                QuestionWidget(
                  question:
                  "How would you rate the ease of use of the PodLove app in coordinating this date? *",
                  options: [
                    "1 (No connection at all)",
                    "2",
                    "3",
                    "4",
                    "5 (Strong connection)"
                  ],
                  onChanged: (selected) => setState(() {
                    _easeOfUse = selected;
                  }),
                ),
                const SizedBox(height: 10),
                /// This question is duplicated in the example.
                QuestionWidget(
                  question:
                  "Another yes/no question (example). *",
                  options: [
                    "Yes",
                    "Somewhat",
                    "No",
                  ],
                  onChanged: (selected) => setState(() {
                    _duplicateYesNo = selected;
                  }),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                  "Any additional comments on using the app?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _someTextFieldController,
                ),

                /// 6. Future Improvements
                const SizedBox(height: 20),
                const CustomText(
                  text: "6. Future Improvements",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                  "Do you have any suggestions for improving the matching process or date experience? *",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _improvementsController,
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                  "How can we make future dates more comfortable and enjoyable for you?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _futureDatesController,
                ),

                /// 7. Optional Additional Feedback
                const SizedBox(height: 20),
                const CustomText(
                  text: "7. Optional Additional Feedback",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Anything else you'd like to share?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                  controller: _optionalFeedbackController,
                ),

                const SizedBox(height: 15),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: _validateAndSubmit,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Center(child: Text("Survey Submitted")),
      content: const Text(
        "Thank you for filling out the survey! Your feedback helps us improve.",
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              // Navigate somewhere after submission
              context.push(RouterPath.home);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.background,
              backgroundColor: AppColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("OK"),
          ),
        ),
      ],
    ),
  );
}

/// Your QuestionWidget remains the same, except now we pass
/// `onChanged: (index) => setState(() { ... })` from the parent:
class QuestionWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final ValueChanged<int?> onChanged;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.options,
    required this.onChanged,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 51, 50, 50),
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(widget.options.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRadioButton(
                  isSelected: _selectedOption == index,
                  onTap: () {
                    setState(() {
                      _selectedOption = index;
                    });
                    widget.onChanged(index);
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOption = index;
                      });
                      widget.onChanged(index);
                    },
                    child: Text(
                      widget.options[index],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 51, 50, 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadioButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromARGB(255, 254, 160, 117),
            width: 2,
          ),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? const Color.fromARGB(255, 254, 160, 117)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
