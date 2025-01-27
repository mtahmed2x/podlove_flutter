import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_radio_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class CompatibilityQuestion extends ConsumerWidget {
  final int pageIndex;

  const CompatibilityQuestion({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access UserNotifier to update the user state
    final userNotifier = ref.read(userProvider.notifier);
    final userState = ref.watch(userProvider);

    // Full list of questions
    final List<Map<String, dynamic>> questions = [
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
        'options': ["Yes", "No"],
        'followUp': {
          'Yes': {
            'question': "If yes, how many kids do you have?",
            'options': [] // Free text input
          }
        }
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
        'followUp': {
          'Never': {
            'question':
                'If "Never", would you be comfortable dating someone who drinks?',
            'options': ["Yes", "No", "Depends"]
          },
        }
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
        'followUp': {
          "Yes, I'm religious" : {
            'question': 'If "Religious", what is your religion or denomination?',
            'options': ["Christianity", "Islam", "Judaism", "Buddhist", "Other"]
          },
          "Yes, I'm spiritual but not religious" : {
            'question': 'If "Spiritual", would you like to describe your spiritual beliefs?',
            'options': [] // Free text input can be handled separately.
          },
        },
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
        'followUp': {
          'Yes': {
            'question': "If yes, which pet do you have?",
            'options': ["Dog", "Cat", "Bird", "Other"]
          }
        }
      },
    ];

    // Split questions into two pages dynamically
    final List<Map<String, dynamic>> pageQuestions = pageIndex == 1
        ? questions.sublist(0, (questions.length / 2).ceil())
        : questions.sublist((questions.length / 2).ceil());

    // Map to store answers for the current page
    final Map<int, dynamic> pageAnswers = {};

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
                ),
                SizedBox(height: 10.h),
                ...List.generate(pageQuestions.length, (index) {
                  final question = pageQuestions[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: _QuestionWidget(
                      question: question['question'],
                      options: question['options'],
                      onChanged: (value) {
                        // Update local answers for this page
                        pageAnswers[index +
                            (pageIndex == 2
                                ? (questions.length / 2).ceil()
                                : 0)] = value;

                        // Handle follow-up questions dynamically
                        if (question.containsKey('followUp') &&
                            question['followUp'].containsKey(value)) {
                          pageAnswers[index + 1] =
                              question['followUp'][value]['options'];
                        }
                      },
                    ),
                  );
                }),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: pageIndex == 1 ? "Next" : "Submit",
                  onPressed: () {
                    // Update user state with answers
                    userNotifier.updateCompatibilityAnswers(pageAnswers);

                    if (pageIndex == 1) {
                      // Navigate to the second page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CompatibilityQuestion(pageIndex: 2),
                        ),
                      );
                    } else {
                      // Submit answers and show confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Compatibility answers submitted!"),
                        ),
                      );
                    }
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

class _QuestionWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final ValueChanged<dynamic> onChanged;

  const _QuestionWidget({
    required this.question,
    required this.options,
    required this.onChanged,
  });

  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  int? _selectedIndex;
  String? _textInput;

  @override
  Widget build(BuildContext context) {
    final isTextInput = widget.options.isEmpty;

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
        if (isTextInput)
          TextField(
            onChanged: (value) {
              setState(() {
                _textInput = value;
              });
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              hintText: "Enter your answer",
            ),
          )
        else
          ...List.generate(widget.options.length, (index) {
            final isSelected = _selectedIndex == index;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRadioButton(
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      widget.onChanged(widget.options[index]);
                    },
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        widget.onChanged(widget.options[index]);
                      },
                      child: Text(
                        widget.options[index],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 51, 50, 50),
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
