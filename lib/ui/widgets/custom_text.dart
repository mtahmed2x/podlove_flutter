import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? wordSpacing;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final double? fontSize;

  const
  CustomText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.wordSpacing,
    this.fontWeight,
    this.fontStyle,
    this.color,
    this.fontSize,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style:
          TextStyle(
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            fontSize: fontSize,

          ),
    );
  }
}
