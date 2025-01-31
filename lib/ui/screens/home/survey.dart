import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';

class Survey extends StatelessWidget {
  const Survey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: " Post-Date Feedback"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomText(
                  text:
                      "Thank you for joining our Pod! Your feedback is crucial in helping us improve the PodLove experience for you and others. Please take a few moments to share your thoughts.",
                  color: Color.fromARGB(255, 39, 87, 166),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: "1. Overall Connection",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 15),
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                      "Please describe what stood out to you about your match (positive or negative).",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                CustomText(
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                      "In your opinion, what factors influenced the level of chemistry you experienced?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                SizedBox(height: 15),
                CustomText(
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                      "Were there any awkward or uncomfortable moments? If so, please describe. *",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                SizedBox(height: 15),
                CustomText(
                  text: "4. Date Satisfaction",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 15),
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "If not, can you share what led to this decision?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                CustomText(
                  text: "5. App Experience",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 15),
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
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
                ),
                const SizedBox(height: 10),
                QuestionWidget(
                  question:
                      "How would you rate the ease of use of the PodLove app in coordinating this date? *",
                  options: [
                    "Yes",
                    "Somewhat",
                    "No",
                  ],
                  onChanged: (selected) {
                    print("Selected option: $selected");
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                      "How would you rate the ease of use of the PodLove app in coordinating this date? *",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                CustomText(
                  text: "6. Future Improvements",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                      "Do you have any suggestions for improving the matching process or date experience? *",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                      "How can we make future dates more comfortable and enjoyable for you?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                CustomText(
                  text: "7. Optional Additional Feedback",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label:
                      "How can we make future dates more comfortable and enjoyable for you?",
                  labelSize: 14,
                  hint: "Write here",
                  maxLines: 5,
                ),
                SizedBox(height: 15),
                CustomRoundButton(text: "Continue", onPressed: () {
                  _showSuccessDialog(context);
                },),
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
        textAlign: TextAlign.center, // Center content text
      ),
      actions: [
        Center( // Center the button
          child: TextButton(
            onPressed: () {
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
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 51, 50, 50)),
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
                      style: TextStyle(
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
            color: Color.fromARGB(255, 254, 160, 117),
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
                  ? Color.fromARGB(255, 254, 160, 117)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
