// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';

class StepperWidget extends StatefulWidget {
  ForgetPasswordController con;

  StepperWidget({required this.con, super.key});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.con.stepThreeSuccess
            ? Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: ThemeClass.primaryColor, width: 2)),
                alignment: Alignment.center,
                child: Icon(
                  Icons.done,
                  size: 16.sp,
                  color: ThemeClass.primaryColor,
                ),
              )
            : Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ThemeClass.hintColor)),
                child: const AppTextHint(
                  title: "٣",
                ),
              ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: 74.w,
          height: widget.con.stepTwoSuccess ? 2.sp : 1.sp,
          color: widget.con.stepTwoSuccess
              ? ThemeClass.primaryColor
              : ThemeClass.hintColor,
        ),
        SizedBox(
          width: 8.w,
        ),
        widget.con.stepTwoSuccess
            ? Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: ThemeClass.primaryColor, width: 2)),
                alignment: Alignment.center,
                child: Icon(
                  Icons.done,
                  size: 16.sp,
                  color: ThemeClass.primaryColor,
                ),
              )
            : Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ThemeClass.hintColor)),
                child: const AppTextHint(
                  title: "٢",
                ),
              ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: 74.w,
          height: widget.con.stepOneSuccess ?  2.sp : 1.sp,
          color: widget.con.stepOneSuccess
              ? ThemeClass.primaryColor
              : ThemeClass.hintColor,
        ),
        SizedBox(
          width: 8.w,
        ),
        widget.con.stepOneSuccess
            ? Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: ThemeClass.primaryColor, width: 2)),
                alignment: Alignment.center,
                child: Icon(
                  Icons.done,
                  size: 16.sp,
                  color: ThemeClass.primaryColor,
                ),
              )
            : Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ThemeClass.hintColor)),
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 4.h),
                child: AppTextRegular(
                  title: "١",
                  textAlign: TextAlign.center,
                  color: ThemeClass.hintColor,
                ),
              ),
      ],
    );
  }
}
