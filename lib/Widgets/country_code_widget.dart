// ignore_for_file: depend_on_referenced_packages
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_assets.dart';
import '../Theme/themeclass.dart';

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 89.w,
      padding: EdgeInsets.symmetric(vertical : 16.h , horizontal: 8.w),
      decoration: BoxDecoration(
        color: ThemeClass.textfieldColor,
        borderRadius: BorderRadius.circular(14.w),
        border: Border.all(color: ThemeClass.secondaryMediumColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.IMG_FLAG,width: 24.w,height: 16.h,),
          SizedBox(width: 6.w,),
          AppTextMedium(title: "20+",color: ThemeClass.fontColor,fontSize: 16.sp,fontWeight: FontWeight.w400,),
        ],
      ),
    );
  }
}
