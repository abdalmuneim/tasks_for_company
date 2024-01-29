import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.fontSize,
    this.textAlign,
    this.backgroundColor,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.maxLines,
    this.textDecoration,
    this.overflow,
    this.fontStyle,
    this.style,
    this.height,
    this.wordSpaces,
    this.textDirection,
  }) : super(key: key);
  final String text;
  final double? fontSize, height, wordSpaces;
  final int? maxLines;
  final Color? color;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  final TextStyle? style;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: fontSize ?? 10.sp,
                color: color,
                fontWeight: fontWeight,
                backgroundColor: backgroundColor,
                decoration: textDecoration,
                fontStyle: fontStyle,
                wordSpacing: wordSpaces,
                height: height,
              ),
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
