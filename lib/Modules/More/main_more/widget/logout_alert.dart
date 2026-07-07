// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';

class LogoutAlertWidget extends StatelessWidget {
  Function() onOkPressed;
  String message;
  LogoutAlertWidget({ required this.onOkPressed,required this.message , super.key});

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
            padding: EdgeInsets.symmetric(horizontal : 16.w,vertical: 16.h),
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
                      width: 26.w,
                      height: 26.h,
                      decoration: BoxDecoration(
                        color: ThemeClass.hintColor,
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      child: Icon(Icons.close,color: ThemeClass.whiteColor,size: 14.sp,),
                    ),
                  ),
                ),
                SizedBox(height: 30.h,),
                Image.asset(
                  AppAssets.IMG_LOGOUT,
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
                      color: ThemeClass.primaryColor,
                      fontFamily: "DINNextLTArabic-Regular"
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                       color : ThemeClass.secondaryColor
                    ),
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
                        padding: EdgeInsets.only(left: 16.w,bottom: 12.h,right: 16.w,top: 8),
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: ThemeClass.secondaryColor,
                          borderRadius: BorderRadius.circular(24.w),
                        ),
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeClass.primaryColor,
                              fontFamily: "DINNextLTArabic-Regular"
                          ),
                          child: AppTextMedium(title : "no".tr,color: ThemeClass.whiteColor,),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    GestureDetector(
                      onTap : (){
                        onOkPressed();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 16.w,bottom: 12.h,right: 16.w,top: 8),
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.w),
                            color: ThemeClass.buttonNotActiveColor,
                             border: Border.all(color: ThemeClass.secondaryColor)
                        ),
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeClass.primaryColor
                          ),
                          child: Text("yes".tr,style: TextStyle(
                              color: ThemeClass.secondaryColor,
                              fontFamily: "DINNextLTArabic-Regular"

                          ),),
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
