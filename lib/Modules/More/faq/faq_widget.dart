// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:iconsax/iconsax.dart';

class FAQWidget extends StatelessWidget {
  String title;
  Function() onTap;
  FAQWidget({required this.title,required this.onTap,Key? key}) : super(key: key);

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
        padding: EdgeInsets.symmetric(vertical : 14.h,horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 8.w),
              child: AppTextRegular(
                title: title,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,color: ThemeClass.borderColor,)

          ],
        ),
      ),
    );
  }
}


