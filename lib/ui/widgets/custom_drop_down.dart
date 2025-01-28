import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String label;
  final List<T> options;
  final T? initialValue;
  final Function(T selectedValue)? onChanged;
  final String Function(T value)? displayText;
  final double width;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.options,
    this.initialValue,
    this.onChanged,
    this.displayText,
    this.width = 400, // Default width
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue ??
        (widget.options.isNotEmpty ? widget.options.first : null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.label,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: widget.width,
          child: DropdownButtonFormField<T>(
            value: _selectedValue,
            onChanged: (T? newValue) {
              setState(() {
                _selectedValue = newValue;
              });
              if (widget.onChanged != null && newValue != null) {
                widget.onChanged!(newValue);
              }
            },
            items: widget.options
                .map((option) => DropdownMenuItem<T>(
                      value: option,
                      child: Text(
                        widget.displayText?.call(option) ?? option.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                    ))
                .toList(),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.accent,
                  width: 0.8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.accent,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
