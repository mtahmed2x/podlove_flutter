import 'package:flutter/material.dart';
import 'custom_text.dart';

class SocialMediaButton extends StatelessWidget {
  final String path;
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const SocialMediaButton({
    super.key,
    required this.path,
    this.onPressed,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
        style: ButtonStyle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(path, width: 24, height: 24),
            const SizedBox(width: 10),
            CustomText(
                text: text,
                color: Color.fromARGB(255, 43, 79, 111),
                fontSize: 16,
                fontWeight: FontWeight.w400)
          ],
        ),
      ),
    );
  }
}
