import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class SelectPersonalityTraits extends ConsumerWidget {
  const SelectPersonalityTraits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.read(userProvider.notifier);


    return Scaffold(
      appBar: CustomAppBar(title: "Personality Traits"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 30.h),
                      CustomText(
                        text: "Rate yourself on the",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "following personality traits",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 40.h),
                      Consumer(
                        builder: (context, ref, _) {
                          return Column(
                            children: [
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
                                onValueChanged: (value) {
                                  userNotifier.updatePersonalityTrait(
                                      "spectrum", value);
                                },
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
                                onValueChanged: (value) {
                                  userNotifier.updatePersonalityTrait(
                                      "balance", value);
                                },
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
                                onValueChanged: (value) {
                                  userNotifier.updatePersonalityTrait(
                                      "focus", value);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Consumer(builder: (context, ref, _) {
                  final state = ref.watch(userProvider);
                  return CustomRoundButton(
                    text: state?.isLoading == true ? "Saving..." : "Continue",
                    onPressed: state?.isLoading == true
                        ? null
                        : () {
                            context.push(RouterPath.selectInterests);
                          },
                  );
                }),
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
  final Function(int) onValueChanged;

  const _CustomScale({
    required this.leftLabel,
    required this.rightLabel,
    required this.pillColors,
    required this.onValueChanged,
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
                  _selectedIndex = index;
                });
                widget.onValueChanged(index);
              },
              child: Container(
                width: 35.w,
                height: 10.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: widget.pillColors[index],
                  border: Border.all(
                    color: isSelected
                        ? AppColors.accent
                        : widget.pillColors[index],
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
