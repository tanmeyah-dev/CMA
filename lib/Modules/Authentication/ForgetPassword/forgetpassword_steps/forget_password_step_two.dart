// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forget_password_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_button_widget.dart';
import '../../../../Widgets/pin_code.dart';
import '../../../../Widgets/simple_animations.dart';

class ForgetPasswordStepTwo extends StatefulWidget {
  ForgetPasswordController con;
  ForgetPasswordStepTwo({required this.con,Key? key}) : super(key: key);

  @override
  State<ForgetPasswordStepTwo> createState() => _ForgetPasswordStepTwoState();
}

class _ForgetPasswordStepTwoState extends State<ForgetPasswordStepTwo> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.con.formKey2,
      child: SizedBox(
        height: 330.h,
        child: Column(
          children: [
            Expanded(child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "otp_des".tr,style: TextStyle(color: ThemeClass.blackColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp)),
                      TextSpan(text: "  ${widget.con.phoneController.text.substring(9)}**", style:  TextStyle(fontWeight: FontWeight.w500,color: ThemeClass.blackColor,fontSize: 16.sp)),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                FadeIn(
                    delay: 2,
                    from: SlideFrom.LEFT,
                    child: PinCodeWidget(
                      controller: widget.con.codeController,
                      onChangeOTP: (value) {
                        if (value.length == 5) {
                          widget.con.activeBtn2 = true;
                          setState(() {});
                        } else {
                          widget.con.activeBtn2 = false;
                          setState(() {});
                        }
                      },
                    )),
                SizedBox(height: 20.h),
                FadeIn(
                    delay: 1.0,
                    from: SlideFrom.LEFT,
                    child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                          onTap: () {
                            if (widget.con.activeResend == true) {
                              widget.con.onResendCode(context);
                            }
                          },
                          child: Text("send_again".tr,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: widget.con.activeResend
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: widget.con.activeResend
                                      ? ThemeClass.blackColor
                                      : ThemeClass.fontColor))),
                      Text(" ${widget.con.start} ${"seconds".tr}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: ThemeClass.blackColor))
                    ])),
              ],
            )),
            FadeIn(
                delay: 1.5,
                from: SlideFrom.LEFT,
                child: Column(
                  children: [
                    widget.con.activeBtn2
                        ? CustomButton(
                        width: 200,
                        title: "confirm".tr,
                        onTap: () {
                          widget.con.secondStep(context);
                        })
                        : CustomButton(
                      width: 200,
                      title: "confirm".tr,
                      onTap: () {},
                      color: ThemeClass.textFieldBackgroundColor,
                      borderColor: ThemeClass.textFieldBackgroundColor,
                      textColor: ThemeClass.hintColor,
                      backgroundColor: ThemeClass.buttonNotActiveColor,
                    ),
                    SizedBox(height: 40.h,)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
