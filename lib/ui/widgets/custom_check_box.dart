import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';

import 'custom_text.dart';

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final Color? color;
  final String label;
  final Color? labelColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;

  const CustomCheckbox({
    super.key,
    this.initialValue = false,
    this.onChanged,
    this.color,
    this.label = '',
    this.labelColor,
    this.labelFontSize,
    this.labelFontWeight,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: widget.color ?? customOrange,
          side: BorderSide(color: customOrange, width: 2),
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(_isChecked);
            }
          },
        ),
        if (widget.label.isNotEmpty)
          GestureDetector(
            onTap: () {
              setState(() {
                _isChecked = !_isChecked;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(_isChecked);
              }
            },
            child: CustomText(
              text: widget.label,
              color: widget.labelColor,
              fontSize: widget.labelFontSize,
              fontWeight: widget.labelFontWeight,
            ),
          ),
      ],
    );
  }
}
