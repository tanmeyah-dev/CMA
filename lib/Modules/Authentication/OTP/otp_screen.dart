// ignore_for_file: depend_on_referenced_packages
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/general_toast.dart';
import '../../../Utilities/loading_screen.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/pin_code.dart';
import 'otp_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class OtpScreen extends StatefulWidget {
  static String routeName = "/otpScreen";

  final String? phoneNumber;
  final Function(String)? onConfirm;

  const OtpScreen({Key? key, this.phoneNumber, this.onConfirm})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends StateMVC<OtpScreen> {
  _OtpScreenState() : super(OtpController()) {
    con = OtpController();
  }

  late OtpController con;

  @override
  void initState() {
    con.onConfirm = widget.onConfirm;
    con.phoneNumber = widget.phoneNumber;
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'open_send_otp_screen',
        parameters: <String,dynamic>{
          "title" : "open_send_otp_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      loading: con.loading,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ThemeClass.whiteColor,
          appBar: BaseAppBar.main(
            enableNotification: false,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: ThemeClass.whiteColor,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Form(
                key: con.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    image(),
                    SizedBox(height: 8.h),
                    otpDes(),
                    SizedBox(height: 40.h,),
                    PinCodeWidget(controller: con.codeController, onChangeOTP: (value) {
                          if(value.length == 5) {
                            con.activeBtn = true;
                            setState(() { });
                          }else {
                            con.activeBtn = false;
                            setState(() { });
                          }
                        },),
                    SizedBox(height: 35.h),
                    timer(),
                    SizedBox(height: 85.h),
                    confirmBtn()
                  ],),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return  AppTextMedium(
        title:  "confirm_number".tr,
    );
  }

  Widget image() {
    return  Image.asset(
        AppAssets.IMG_OTP,
        height: 300.h,
        width: 300.w,
        fit: BoxFit.fill,
    );
  }


  Widget otpDes(){
    return  RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: "otp_des".tr,style: TextStyle(color: ThemeClass.blackColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp)),
          TextSpan(text: "  ${con.phoneNumber?.substring(9)}**", style:  TextStyle(fontWeight: FontWeight.w500,color: ThemeClass.blackColor,fontSize: 16.sp)),
        ],
      ),
    );

  }


  Widget timer() {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                if (con.activeResend == true) {
                  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                  analytics.logEvent(
                      name: 'request_resend_otp_screen',
                      parameters: <String,dynamic>{
                        "title" : "request_resend_otp_screen"
                      }
                  );
                    con.onResendCode(context);
                }
              },
              child: Text(
                "send_again".tr,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight:
                        con.activeResend ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 16.sp,
                    color: con.activeResend
                        ? ThemeClass.blackColor
                        : ThemeClass.fontColor),
              )),
          Text(
            " ${con.start} ${"seconds".tr}",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: ThemeClass.blackColor),
          ),
        ],
    );
  }

  Widget confirmBtn() {
    return Column(
      children: [
         con.activeBtn == true ?  CustomButton(
            width: 200,
            title: "confirm".tr,
            onTap: () {
              if (con.formKey.currentState!.validate()) {
                final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                analytics.logEvent(
                    name: 'submit_otp_screen',
                    parameters: <String,dynamic>{
                      "title" : "submit_otp_screen"
                    }
                );
                con.onConfirmPin();
              } else {
                ToastHelper.showError(context,message: "otp_error".tr);
              }
            },
          ) :CustomButton(
            color: ThemeClass.textFieldBackgroundColor,
            borderColor: ThemeClass.textFieldBackgroundColor,
            textColor: ThemeClass.hintColor,
            backgroundColor: ThemeClass.buttonNotActiveColor,
            width: 200.w,
            title: "confirm".tr,
            onTap: () {
            },
          )  ,
      ],
    );
  }
}
