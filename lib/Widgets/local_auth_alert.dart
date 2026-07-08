// ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_assets.dart';
import '../Theme/themeclass.dart';

class LocalAuthAlert extends StatelessWidget {
  Function() onLogoutPress;
  LocalAuthAlert({ required this.onLogoutPress , super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 355.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:ThemeClass.whiteColor,
              borderRadius: BorderRadius.circular(40.w),
            ),
            padding: EdgeInsets.all(20.w),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height : 15.h),
                Image.asset(
                  AppAssets.IMG_LOGOUT,
                  width: 150.w,
                  height: 145.h,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: 30.h,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: ThemeClass.primaryColor),
                  child: Text(
                    "logout_des".tr,
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
                          onLogoutPress();
                        },
                        child: Container(
                          width: 152.w,
                          height: 51.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: ThemeClass.primaryColor),
                            borderRadius: BorderRadius.circular(26.w),
                          ),
                          alignment: Alignment.center,
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeClass.primaryColor
                            ),
                            child: Text("yes".tr),
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap : (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 152.w,
                        height: 51.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: ThemeClass.primaryColor),
                          borderRadius: BorderRadius.circular(26.w),
                          color: ThemeClass.primaryColor
                        ),
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeClass.primaryColor
                          ),
                          child: Text("no".tr,style: TextStyle(
                            color: ThemeClass.whiteColor
                          ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
