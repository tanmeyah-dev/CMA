// ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_assets.dart';
import '../Theme/themeclass.dart';

class BiometricAlert extends StatelessWidget {
  Function() onOkPressed;
  BiometricAlert({ required this.onOkPressed , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 328.w,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color:ThemeClass.whiteColor,
              borderRadius: BorderRadius.circular(24.w),
            ),
            padding: EdgeInsets.symmetric(horizontal : 16.w,vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: ThemeClass.hintColor,
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                      child: Icon(Icons.close,color: ThemeClass.whiteColor,size: 14.sp,),
                    ),
                  ),
                ),
                SizedBox(height: 26.h,),
                Image.asset(
                  AppAssets.IMG_BIOMETRIC,
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 16.h,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: ThemeClass.primaryColor),
                  child: Text(
                    "bio_alert_des".tr,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap : (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 140.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w),
                            color: ThemeClass.buttonNotActiveColor
                        ),
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeClass.primaryColor
                          ),
                          child: Text("no".tr,style: TextStyle(
                              color: ThemeClass.hintColor
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    GestureDetector(
                      onTap : (){
                        onOkPressed();
                      },
                      child: Container(
                        width: 140.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: ThemeClass.primaryColor,
                          borderRadius: BorderRadius.circular(14.w),
                        ),
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeClass.primaryColor
                          ),
                          child: AppTextMedium(title : "yes".tr,color: ThemeClass.whiteColor,),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h,),
        ],
      ),
    );
  }
}
