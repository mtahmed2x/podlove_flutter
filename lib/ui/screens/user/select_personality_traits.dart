import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPersonalityTraits extends StatelessWidget {
  const SelectPersonalityTraits({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: CustomAppBar(title: "Personality Traits"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/podLove.png",
                        width: 250.w,
                        height: 50.h,
                      ),
                      SizedBox(height: 25.h),
                      CustomText(
                        text: "Rate yourself on the",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "following personality traits",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(height: 20.h),
                      _CustomScale(
                        leftLabel: "Introvert",
                        rightLabel: "Extrovert",
                        pillColors: [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.blue,
                          Colors.indigo,
                          Colors.purple,
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _CustomScale(
                        leftLabel: "Homebody",
                        rightLabel: "Adventurous",
                        pillColors: [
                          Colors.brown,
                          Colors.teal,
                          Colors.amber,
                          Colors.cyan,
                          Colors.lime,
                          Colors.pink,
                          Colors.grey,
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _CustomScale(
                        leftLabel: "Pragmatist",
                        rightLabel: "Optimist",
                        pillColors: [
                          Colors.deepPurple,
                          Colors.lightBlue,
                          Colors.lightGreen,
                          Colors.orangeAccent,
                          Colors.redAccent,
                          Colors.yellowAccent,
                          Colors.deepOrange,
                        ],
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomScale extends StatefulWidget {
  final String leftLabel;
  final String rightLabel;
  final List<Color> pillColors;

  const _CustomScale({
    required this.leftLabel,
    required this.rightLabel,
    required this.pillColors,
  });

  @override
  State<_CustomScale> createState() => _CustomScaleState();
}

class _CustomScaleState extends State<_CustomScale> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.leftLabel,
              style: TextStyle(fontSize: 16.sp),
            ),
            Text(
              widget.rightLabel,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = isSelected ? null : index;
                });
              },
              child: Container(
                width: 40.w,
                height: 15.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: widget.pillColors[index],
                  border: Border.all(
                    color: isSelected ? Colors.black : widget.pillColors[index],
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
