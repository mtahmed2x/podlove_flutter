import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_radio_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class CompatibilityQuestion extends StatefulWidget {
  final int pageIndex;

  const CompatibilityQuestion({super.key, required this.pageIndex});

  @override
  State<CompatibilityQuestion> createState() => _CompatibilityQuestionState();
}

class _CompatibilityQuestionState extends State<CompatibilityQuestion> {
  late List<Map<String, dynamic>> questions;
  final Map<int, String?> selectedAnswers = {};
  final Map<int, TextEditingController> textControllers = {};

  @override
  void initState() {
    super.initState();
    questions = [
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
      {
        'question': "Do you have kids? *",
        'options': ["Yes", "No"]
      },
      {
        'question':
        'If yes, how many kids do you have?',
        'options': [] // Free text input can be handled separately.
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
        'question': "Do you smoke? *",
        'options': ["Yes", "No"]
      },
      {
        'question': "Will you date a smoker? *",
        'options': ["Yes", "No", "Maybe"]
      },
      {
        'question':
        "How would you describe your drinking habits? * (Select the option that best describes you.)",
        'options': [
          "Never – I don't drink alcohol at all",
          "Rarely – I drink only on special occasions (e.g., holidays, celebrations)",
          "Socially – I drink occasionally in social settings",
          "Occasionally – I drink a few times a month or less",
          "Regularly – I drink frequently, such as weekly or more",
          "Prefer not to say – I'd rather not disclose this information"
        ],
      },
      {
        'question':
        'If "Never", would you be comfortable dating someone who drinks?',
        'options': ["Yes", "No", "Depends"]
      },
      {
        'question':
        "Do you consider yourself religious or spiritual? * (Select the option that best describes you.)",
        'options': [
          "Yes, I'm religious",
          "Yes, I'm spiritual but not religious",
          "No, I'm not religious or spiritual",
          "Prefer not to say"
        ],
      },
      {
        'question': 'If "Religious", what is your religion or denomination?',
        'options': ["Christianity", "Islam", "Judaism", "Buddhist", "Other"]
      },
      {
        'question':
        'If "Spiritual", would you like to describe your spiritual beliefs?',
        'options': [] // Free text input can be handled separately.
      },
      {
        'question':
        "How important is religion or spirituality in your life? * (Select the option that best describes you.)",
        'options': [
          "Not important at all",
          "Somewhat important",
          "Moderately important",
          "Very important",
          "Extremely important"
        ]
      },
      {
        'question':
        "Would you date someone with different religious or spiritual beliefs? * (Select one option.)",
        'options': [
          "Yes, I'm open to dating someone with different beliefs",
          "No, I prefer someone who shares my beliefs",
          "Maybe, it depends on their level of practice or respect for my beliefs"
        ]
      },
      {
        'question':
        "How would you describe your level of political engagement? * (Select the option that best describes you.)",
        'options': [
          "Not at all political – I don't follow politics and prefer to avoid political discussions",
          "Slightly political – I'm minimally engaged, but I occasionally follow major events",
          "Somewhat political – I stay informed about politics and discuss it occasionally",
          "Very political – I'm actively engaged and enjoy discussing political topics",
          "Significantly political – Politics is a significant part of my life, and I'm deeply involved (e.g., activism, campaigning)"
        ]
      },
      {
        'question':
        "Would you date someone with different political beliefs? * (Select one option.)",
        'options': [
          "Yes, I'm open to dating someone with different political views",
          "No, I prefer someone who aligns with my political beliefs",
          "Maybe, it depends on the specific issues or level of engagement"
        ]
      },
      {
        'question': "Do you have pets? *",
        'options': ["Yes", "No"],
      },
      {
        'question': "If yes, which pet do you have?",
        'options': ["Dog", "Cat", "Bird", "Other"]
      }
    ];

    final totalQuestions = 6;
    final startIndex = widget.pageIndex == 1 ? 0 : totalQuestions;
    final endIndex = widget.pageIndex == 1 ? totalQuestions : questions.length;
    questions = questions.sublist(startIndex, endIndex);
  }

  void _validateAndProceed(BuildContext context) {
    if (selectedAnswers.length < questions.length || selectedAnswers.containsValue(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: SizedBox(
            width: 400.w,
            child: AwesomeSnackbarContent(
              title: "Answer all questions",
              message: "Please answer all questions before proceeding.",
              contentType: ContentType.failure,
            ),
          ),
        ),
      );
      return;
    }

    if (widget.pageIndex == 1) {
      context.push('${RouterPath.compatibalityQuestion}/2');
    } else {
      context.push(RouterPath.selectPersonalityTraits);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Discover Compatibility", isLeading: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Let’s Discover Your Compatibility!",
                  color: AppColors.primaryText,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 30.h),
                ...List.generate(questions.length, (index) {
                  final question = questions[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: question['options'].isEmpty
                        ? _TextFieldQuestionWidget(
                      question: question['question'],
                      onTextChanged: (value) {
                        selectedAnswers[index] = value;
                      },
                    )
                        : _QuestionWidget(
                      question: question['question'],
                      options: question['options'],
                      onOptionSelected: (value) {
                        setState(() {
                          selectedAnswers[index] = value;
                        });
                      },
                    ),
                  );
                }),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: widget.pageIndex == 1 ? "Next" : "Submit",
                  onPressed: () => _validateAndProceed(context),
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

class _TextFieldQuestionWidget extends StatelessWidget {
  final String question;
  final Function(String) onTextChanged;

  const _TextFieldQuestionWidget({
    required this.question,
    required this.onTextChanged,
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
            color: const Color.fromARGB(255, 51, 50, 50),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          onChanged: onTextChanged,
          decoration: InputDecoration(
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
            hintText: "Input here",
          ),

        ),
      ],
    );
  }
}

class _QuestionWidget extends StatefulWidget {
  final String question;
  final List<dynamic> options;
  final Function(String) onOptionSelected;

  const _QuestionWidget({
    required this.question,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 51, 50, 50),
          ),
        ),
        SizedBox(height: 8.h),
        ...widget.options.map((option) {
          final isSelected = _selectedOption == option;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOption = option;
                });
                widget.onOptionSelected(option);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRadioButton(
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedOption = option;
                      });
                      widget.onOptionSelected(option);
                    },
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isSelected ? AppColors.primaryText : const Color.fromARGB(255, 51, 50, 50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}


