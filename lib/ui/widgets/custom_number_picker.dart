import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';

class CustomNumberPicker extends StatefulWidget {
  final int start;
  final int end;
  final int initialValue;
  final Function(int) onNumberSelected;

  const CustomNumberPicker({
    super.key,
    required this.start,
    required this.end,
    required this.initialValue,
    required this.onNumberSelected,
  });

  @override
  State<CustomNumberPicker> createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  late int selectedNumber;

  @override
  void initState() {
    super.initState();
    selectedNumber = widget.initialValue; // Set the default selected number
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 175.w,
          height: 400.h, // Adjusted for screen responsiveness
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50.h, // Adjusted item height
            perspective: 0.01, // Slight 3D effect
            physics: const FixedExtentScrollPhysics(), // Snaps to items
            onSelectedItemChanged: (index) {
              setState(() {
                selectedNumber = widget.start + index; // Update selected number
              });
              widget.onNumberSelected(selectedNumber); // Notify parent widget
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                final number = widget.start + index;
                final isSelected = number == selectedNumber;

                return Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize:
                          isSelected ? 24.sp : 18.sp, // Responsive font size
                      color: isSelected ? AppColors.accent : Colors.black54,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
              childCount: (widget.end - widget.start + 1),
            ),
          ),
        ),
        // Top Border
        Positioned(
          top: 175.h, // Adjusted for screen responsiveness
          child: Container(
            width: 175.w, // Responsive border width
            height: 1.2.h, // Responsive thickness
            color: AppColors.accent,
          ),
        ),
        // Bottom Border
        Positioned(
          bottom: 175.h,
          child: Container(
            width: 175.w, // Responsive border width
            height: 1.2.h, // Responsive thickness
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}
