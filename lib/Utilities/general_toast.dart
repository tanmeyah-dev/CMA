import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../Theme/themeclass.dart';

class ToastHelper {
  // static  showError(
  //     BuildContext context, {required String message})  {
  //    Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 2,
  //     backgroundColor:  Colors.red,
  //     textColor: Colors.white,
  //     fontSize: 16.sp,
  //   );
  // }
  //
  // static  showSuccess(
  //     BuildContext context, {required String message})  {
  //    Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 2,
  //       backgroundColor: Colors.blueAccent,
  //       textColor: Colors.white,
  //       fontSize: 16.sp
  //    );
  // }


  static showError(BuildContext context , {String? message}){
    final toast = showToast(message??"",
      context: context,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: Color(0xFFAC2734),
      borderRadius: BorderRadius.circular(20.w),
      textStyle: TextStyle(
          color: ThemeClass.whiteColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp,fontWeight: FontWeight.w400),
    );
    return toast;
  }


  static showSuccess(BuildContext context,{String? message}){
    final toast = showToast(message??"",
      context: context,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor:  Color(0xFF027243),
      borderRadius: BorderRadius.circular(10.w),
      textStyle: TextStyle(
          color: ThemeClass.whiteColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp,fontWeight: FontWeight.w400),
    );
    return toast;
  }



  static showWarning(BuildContext context , {String? message}){
    final toast = showToast(message??"",
      context: context,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor:  Color(0xFF0F61AC) ,
      borderRadius: BorderRadius.circular(20.w),
      textStyle: TextStyle(
          color: ThemeClass.whiteColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp,fontWeight: FontWeight.w400),
    );
    return toast;
  }



}