// ignore_for_file: depend_on_referenced_packages
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_assets.dart';
import '../Theme/themeclass.dart';

class CountryCodeWidget extends StatelessWidget {
  final bool inline;

  const CountryCodeWidget({super.key, this.inline = false});

  @override
  Widget build(BuildContext context) {
    final codeLabel = AppTextMedium(
      title: inline ? '+20' : '20+',
      color: ThemeClass.fontColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    );

    final flag = Image.asset(
      AppAssets.IMG_FLAG,
      width: 24.w,
      height: 16.h,
    );

    if (inline) {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            codeLabel,
            SizedBox(width: 6.w),
            flag,
          ],
        ),
      );
    }

    return Container(
      width: 89.w,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: ThemeClass.textfieldColor,
        borderRadius: BorderRadius.circular(14.w),
        border: Border.all(color: ThemeClass.secondaryMediumColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          flag,
          SizedBox(width: 6.w),
          codeLabel,
        ],
      ),
    );
  }
}
