// ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_assets.dart';
import '../Theme/themeclass.dart';

class LocationAlert extends StatelessWidget {
  Function() onLocationTapped;
  LocationAlert({ required this.onLocationTapped , super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 355.w,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color:ThemeClass.whiteColor,
                borderRadius: BorderRadius.circular(24.w),
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.close,color: ThemeClass.whiteColor,size: 14.sp,),
                      ),
                    ),
                  ),
                  SizedBox(height: 26.h,),
                  Image.asset(
                    AppAssets.IMG_LOCATION,
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: ThemeClass.primaryColor),
                      child: Text(
                        "location_alert_des".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "DINNextLTArabic-Regular",
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  GestureDetector(
                    onTap : (){
                      onLocationTapped();
                    },
                    child: Container(
                      width: 296.w,
                      height: 51.h,
                      decoration: BoxDecoration(
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
                        child: Text("الاعدادات",style: TextStyle(color: ThemeClass.whiteColor,fontWeight: FontWeight.w600,fontFamily: "DINNextLTArabic-Regular"),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
