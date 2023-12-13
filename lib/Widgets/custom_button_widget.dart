// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Theme/themeclass.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      this.width = 348,
      this.height = 52,
      this.radius = 24,
      this.color,
      required this.onTap,
      this.backgroundColor,
      this.style,
      this.borderColor,
      this.decoration,
      this.textColor,
      this.edgeInsets,
      this.fontSize,
      this.iconWidget,
      this.fontWeight
      })
      : super(key: key);
  final Function onTap;
  final String title;
  final double width, height;
  final Color? color;
  final double? radius;
  final TextStyle? style;
  final BoxDecoration? decoration;
  final Widget? iconWidget;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsets? edgeInsets;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: height.h,
        width: width.w,
        padding: edgeInsets ?? EdgeInsets.only(bottom: 8.h),
        decoration: decoration ??
            BoxDecoration(
              borderRadius: radius == null
                  ? BorderRadius.circular(14.w)
                  : BorderRadius.circular(radius!.w),
              border: Border.all(color: borderColor ?? ThemeClass.primaryColor),
              color: backgroundColor ?? ThemeClass.primaryColor,
            ),
        child: iconWidget != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    style: style ??
                        TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  iconWidget!
                ],
              )
            : Text(
                title,
                style: style ??
                    TextStyle(
                        color: textColor ?? ThemeClass.whiteColor,
                        fontSize: fontSize ?? 20.sp,
                        fontWeight: fontWeight ?? FontWeight.w500),
              ),
      ),
    );
  }
}
