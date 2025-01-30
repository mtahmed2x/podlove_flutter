import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';

enum TextFieldType { text, number, email, password }

class CustomTextField extends StatefulWidget {
  final TextFieldType fieldType;
  final dynamic label;
  final Color? labelTextColor;
  final int? labelSize;
  final String? hint;
  final Color? hintTextColor;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Color? borderColor;
  final double? borderRadius;
  final int? maxLength;
  final int? maxLines;
  final TextStyle? textStyle;
  final bool? enabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.fieldType = TextFieldType.text,
    this.label,
    this.labelTextColor,
    this.labelSize,
    this.hint,
    this.hintTextColor,
    this.keyboardType,
    this.obscureText,
    this.prefixIcon,
    this.borderColor,
    this.borderRadius,
    this.maxLength,
    this.maxLines = 1,
    this.textStyle,
    this.enabled = true,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.fieldType == TextFieldType.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label is String
            ? Text(
                widget.label,
                style: TextStyle(
                  fontSize: (widget.labelSize ?? 16).sp,
                  fontWeight: FontWeight.w400,
                  color: widget.labelTextColor ??
                      const Color.fromARGB(255, 51, 51, 51),
                ),
              )
            : RichText(
                text: widget.label as TextSpan,
              ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType ?? _getKeyboardType(),
          obscureText: widget.fieldType == TextFieldType.password && _isObscure,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          style: widget.textStyle ??
              TextStyle(
                fontSize: 14.sp,
              ),
          enabled: widget.enabled,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: widget.hintTextColor ??
                  const Color.fromARGB(255, 121, 121, 121),
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.fieldType == TextFieldType.password
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: customOrange,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? customOrange),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor ?? customOrange, width: 2.w),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
            ),
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.w),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
            ),
          ),
          cursorColor: AppColors.accent,
          validator: widget.validator,
          onChanged: widget.onChanged,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.text:
      case TextFieldType.password:
        return TextInputType.text;
    }
  }
}
