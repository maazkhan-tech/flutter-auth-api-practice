import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double letterSpacing;

  const LabelText({
    super.key,
    required this.text,
    this.textColor = Colors.red,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.letterSpacing = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
          ),
        ),
      ],
    );
  }
}
