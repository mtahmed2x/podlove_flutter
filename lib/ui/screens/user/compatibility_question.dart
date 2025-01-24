import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_radio_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class CompatibilityQuestion extends StatefulWidget {
  final int pageIndex;

  const CompatibilityQuestion({super.key, required this.pageIndex});

  @override
  State<CompatibilityQuestion> createState() => _CompatibilityPageState();
}

class _CompatibilityPageState extends State<CompatibilityQuestion> {
  List<Map<String, dynamic>> questions = [
    {
      'question':
          "Do you prefer spending your weekends socializing in larger gatherings or relaxing at home with a few close friends? *",
      'options': ["Larger gatherings", "Relaxing with close friends"]
    },
    {
      'question':
          "When faced with a major life decision, do you usually follow your head (logic) or your heart (feelings)? *",
      'options': ["Head (logic)", "Heart (feelings)"]
    },
    {
      'question': "Which of these activities sounds most appealing to you? *",
      'options': [
        "A weekend hiking trip in nature",
        "A museum or art gallery visit",
        "A cozy movie night at home",
        "A concert or live music event"
      ]
    },
    {
      'question': "How important is personal growth in your life? *",
      'options': [
        "Extremely important – I am always working on bettering myself",
        "Moderately important – I like to grow but not obsessively",
        "Not important – I prefer to maintain the status quo"
      ]
    },
    {
      'question': "How do you like to show affection? *",
      'options': [
        "Physical touch (hugs, kisses, etc.)",
        "Words of affirmation (compliments, verbal expressions of love)",
        "Acts of service (doing things to help my partner)",
        "Quality time (spending focused time together)"
      ]
    },
    {
      'question': "How do you envision your ideal future? *",
      'options': [
        "Building a family with a partner",
        "Traveling the world and having enriching experiences",
        "Focusing on my career and personal goals",
        "Living a simple, peaceful life surrounded by loved ones"
      ]
    },
    // Page 2
    {
      'question': "Do you have kids? *",
      'options': ["Yes", "No"]
    },
    {
      'question': "Do you want kids in the future? *",
      'options': ["Yes", "No", "Maybe"]
    },
    {
      'question': "Will you date a person who has kids? *",
      'options': ["Yes", "No", "Maybe"]
    },
    {
      'question': "Do you smoke?",
      'options': ["Yes", "No"]
    },
    {
      'question': "Will you date a smoker? ",
      'options': ["Yes", "No", "Maybe"]
    },
    {
      'question':
          "How would you describe your drinking habits? * (Select the option that best describes you.)",
      'options': ["Yes", "No", "Maybe"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> pageQuestions;

    if (widget.pageIndex == 1) {
      pageQuestions = questions.sublist(0, 6);
    } else {
      pageQuestions = questions.sublist(6);
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Discover Compatibility"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                CustomText(
                  text: "Let’s Discover Your Compatibility!",
                  color: AppColors.primaryText,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10.h),
                ...List.generate(pageQuestions.length, (index) {
                  return Column(
                    children: [
                      _QuestionWidget(
                        question: pageQuestions[index]['question'],
                        options: pageQuestions[index]['options'],
                        onChanged: (selected) {
                          print("Selected option: $selected");
                        },
                      ),
                      SizedBox(height: 10.h),
                    ],
                  );
                }),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: widget.pageIndex == 1 ? "Next" : "Continue",
                  onPressed: () {
                    if (widget.pageIndex == 1) {
                    } else {}
                  },
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// QuestionWidget remains the same
class _QuestionWidget extends StatelessWidget {
  final String question;
  final List<String> options;
  final ValueChanged<int?> onChanged;

  const _QuestionWidget({
    required this.question,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 51, 50, 50)),
        ),
        SizedBox(height: 8.h),
        ...List.generate(options.length, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRadioButton(
                  isSelected: false,
                  onTap: () {
                    onChanged(index);
                  },
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onChanged(index);
                    },
                    child: Text(
                      options[index],
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 51, 50, 50)),
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
