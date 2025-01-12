import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/colors.dart';

import 'custom_text.dart';

class OTPInputField extends StatefulWidget {
  final int length; // The number of OTP digits
  final TextEditingController? controller; // Optionally, pass a controller
  final Function(String)? onChanged; // Callback to capture the input value

  const OTPInputField({
    super.key,
    this.length = 6, // Default to 6 digits
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
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align the column to the start
      children: [
        // OTP input fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.length, (index) {
            // Check if the text field is empty or has text
            bool isFilled = _controllers[index].text.isNotEmpty;

            return SizedBox(
              width: 50, // Adjust the width as per your design
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
                maxLength: 1, // Only one digit per field
                decoration: InputDecoration(
                  counterText: "", // Hide the counter text
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isFilled
                          ? customOrange
                          : customOrangeLight, // Dark if filled, light if empty
                      width: 0.8,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isFilled
                          ? customOrange
                          : customOrangeLight, // Dark if filled, light if empty
                      width: 0.8,
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
        SizedBox(height: 10), // Space between OTP and Resend OTP
        Padding(
          padding: EdgeInsets.only(
              right: 10.0), // Adjust the padding here to move it left
          child: Align(
            alignment: Alignment.centerRight, // Align the text to the right
            child: GestureDetector(
              onTap: () {
                print("Resend OTP clicked");
              },
              child: CustomText(
                text: 'Resend OTP',
                style: TextStyle(
                    color: customOrange, // Your custom color for the text
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: customOrange // Underline the text
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
