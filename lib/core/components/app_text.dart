import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
    this.text, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.fontWeight,
  });

  final String text;
  final Color? color;
  final int? maxLines;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: color,
      ),
    );
  }
}
