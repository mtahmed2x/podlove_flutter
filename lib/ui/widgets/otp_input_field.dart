import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

class OTPInputField extends StatefulWidget {
  final int length;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const OTPInputField({
    super.key,
    this.length = 6,
    this.controller,
    this.onChanged,
  });

  @override
  OTPInputFieldState createState() => OTPInputFieldState();
}

class OTPInputFieldState extends State<OTPInputField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _controllers =
        List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.length, (index) {
            bool isFilled = _controllers[index].text.isNotEmpty;

            return SizedBox(
              width: 50.w,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp),
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isFilled ? customOrange : customOrangeLight,
                      width: 0.8.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: isFilled ? customOrange : customOrangeLight,
                      width: 0.8.w,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    // Update the widget state
                  });

                  widget.onChanged?.call(value);
                  // Move focus to the next field when a digit is entered
                  if (value.isNotEmpty && index < widget.length - 1) {
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  }
                },
                onEditingComplete: () {
                  // Automatically move focus to the next field after entering a digit
                  if (index < widget.length - 1) {
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  }
                },
              ),
            );
          }),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(right: 10.0.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                print("Resend OTP clicked");
              },
              child: CustomText(
                text: 'Resend OTP',
                style: TextStyle(
                    color: customOrange,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: customOrange),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
