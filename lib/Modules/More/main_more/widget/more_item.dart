// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';

class MoreItemWidget extends StatelessWidget {

   String image;
   String title;
   bool hint;
   Function() onTap;
   MoreItemWidget({required this.image, required this.title,required this.hint,required this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeClass.termsBackground,
          borderRadius: BorderRadius.circular(16.sp),
        ),
        padding: EdgeInsets.symmetric(vertical : 8.h,horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 8.w),
              child: AppTextRegular(
                title: title,
                color: image == AppAssets.IMG_MORE_ABOUT ? ThemeClass.primaryColor :  hint ? const Color(0xff6a4b4c80) : ThemeClass.fontColor,
                fontSize: 18.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: image == AppAssets.IMG_MORE_ABOUT ? const Color(0xFFF3D4D2) : const Color(0xFFE4E4E4),
              ),
              child: Image.asset(
                image,
                color: image == AppAssets.IMG_MORE_ABOUT ? ThemeClass.primaryColor :  hint ? const Color(0xff6a4b4c80) : ThemeClass.fontColor,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


