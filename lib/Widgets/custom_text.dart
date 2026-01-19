// ignore_for_file: depend_on_referenced_packages, annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/themeclass.dart';

class AppTextBold extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLines;

  const AppTextBold(
      {Key? key,
      required this.title,
      this.fontWeight,
      this.fontSize,
      this.color,
      this.textAlign,
        this.textDecoration,
        this.maxLines,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize?? 24.sp,
          fontWeight: fontWeight?? FontWeight.bold,
          color: color ?? ThemeClass.primaryColor,
         decoration: textDecoration != null ? TextDecoration.underline : null
      ),
      textAlign: textAlign?? TextAlign.center,
      maxLines: maxLines,
    );
  }
}

class AppTextMedium extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;


  const AppTextMedium(
      {Key? key,
      required this.title,
      this.fontWeight,
      this.fontSize,
        this.textAlign,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize?? 20.sp,
          fontWeight: fontWeight??  FontWeight.w600,
          color: color?? ThemeClass.primaryColor),
      textAlign:textAlign?? TextAlign.center,
    );
  }
}

class AppTextRegular extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  const AppTextRegular(
      {Key? key,
      required this.title,
      this.fontWeight,
      this.fontSize,
      this.color, this.textAlign,this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize ?? 18.sp,
          fontWeight: fontWeight??  FontWeight.w400,
          color: color ?? ThemeClass.fontColor,
      ),
      maxLines: maxLines?? null,
      textAlign: textAlign?? TextAlign.center,
    );
  }
}

class AppTextHint extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;

  const AppTextHint(
      {Key? key,
      required this.title,
      this.fontWeight,
      this.fontSize,
      this.color,
      this.textAlign,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize??  14.sp,
          fontWeight: fontWeight??  FontWeight.w400,
          color: color ?? ThemeClass.hintColor),
      textAlign: textAlign?? TextAlign.center,
    );
  }
}

class AppTextUnderline extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;


  const AppTextUnderline({Key? key, required this.title, required this.onTap, this.color, this.fontWeight, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? ThemeClass.fontColor;
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
            fontSize: fontSize ?? 16.sp,
            color: textColor,
            decoration: TextDecoration.underline,
            decorationColor: textColor,
            fontWeight: fontWeight?? FontWeight.w400,
        ),
      ),
    );
  }
}

