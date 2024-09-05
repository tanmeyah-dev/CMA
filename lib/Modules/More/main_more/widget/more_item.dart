// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:iconsax/iconsax.dart';

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
        padding: EdgeInsets.symmetric(vertical : 12.h,horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              color: image == AppAssets.IMG_MORE_ABOUT ? ThemeClass.primaryColor :  hint ? const Color(0xFF6A4B4C80) : ThemeClass.fontColor,
              width: 24.w,
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 8.w),
              child: AppTextRegular(
                title: title,
                color: image == AppAssets.IMG_MORE_ABOUT ? ThemeClass.primaryColor :  hint ? const Color(0xff6a4b4c80) : ThemeClass.fontColor,
                fontSize: 18.sp,
              ),
            ),
            Spacer(),
            Icon(Iconsax.arrow_square_left)

          ],
        ),
      ),
    );
  }
}


