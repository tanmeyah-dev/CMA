// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/general_toast.dart';
import '../../../Utilities/loading_screen.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/pin_code.dart';
import 'otp_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otpScreen';

  final String? phoneNumber;
  final Function(String)? onConfirm;

  const OtpScreen({super.key, this.phoneNumber, this.onConfirm});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends StateMVC<OtpScreen> {
  _OtpScreenState() : super(OtpController()) {
    con = controller as OtpController;
  }

  late OtpController con;

  @override
  void initState() {
    super.initState();
    con.setupSession(
      phone: widget.phoneNumber,
      confirmCallback: widget.onConfirm,
    );
    FirebaseAnalytics.instance.logEvent(
      name: 'open_send_otp_screen',
      parameters: <String, Object>{'title': 'open_send_otp_screen'},
    );
  }

  void _onOtpChanged(String value) {
    con.updateActiveBtn(value);
  }

  Future<void> _onResend() async {
    if (!con.activeResend) return;
    _logAnalytics('request_resend_otp_screen');
    await con.onResendCode(context);
  }

  Future<void> _onConfirm() async {
    FocusManager.instance.primaryFocus?.unfocus();
    _logAnalytics('submit_otp_screen');

    if (!con.formKey.currentState!.validate()) {
      ToastHelper.showError(context, message: 'otp_error'.tr);
      return;
    }

    await con.onConfirmPin();
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final horizontalPadding = 30.w;
    final buttonWidth = 1.sw - 60.w;

    return LoadingScreen(
      loading: con.loading,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ThemeClass.whiteColor,
          resizeToAvoidBottomInset: false,
          appBar: BaseAppBar.main(enableNotification: false),
          body: Form(
            key: con.formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        SizedBox(height: 24.h),
                        image(keyboardVisible: keyboardInset > 0),
                        SizedBox(height: 16.h),
                        otpDes(),
                        SizedBox(height: 40.h),
                        PinCodeWidget(
                          controller: con.codeController,
                          length: OtpController.otpLength,
                          onChangeOTP: _onOtpChanged,
                        ),
                        SizedBox(height: 35.h),
                        timer(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    16.h,
                    horizontalPadding,
                    keyboardInset > 0 ? keyboardInset + 12.h : 20.h,
                  ),
                  child: confirmBtn(buttonWidth),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget image({required bool keyboardVisible}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: keyboardVisible ? 219.h : 320.h,
      width: keyboardVisible ? 211.w : 320.w,
      child: Image.asset(
        AppAssets.IMG_OTP,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget otpDes() {
    return Column(
      children: [
        AppTextMedium(
          title: 'confirm_number'.tr,
          color: ThemeClass.primaryColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 12.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '${'otp_des'.tr} ',
                style: TextStyle(
                  color: ThemeClass.borderColor,
                  fontFamily: 'DINNextLTArabic-Regular',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
              TextSpan(
                text: con.maskedPhoneSuffix,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ThemeClass.blackColor,
                  fontFamily: 'DINNextLTArabic-Regular',
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget timer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: _onResend,
          child: Text(
            'send_again'.tr,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight:
                  con.activeResend ? FontWeight.w600 : FontWeight.w400,
              fontSize: 16.sp,
              color: con.activeResend
                  ? ThemeClass.blackColor
                  : ThemeClass.fontColor,
            ),
          ),
        ),
        Text(
          ' ${con.start} ${'seconds'.tr}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: ThemeClass.blackColor,
          ),
        ),
      ],
    );
  }

  Widget confirmBtn(double buttonWidth) {
    return CustomButton(
      width: buttonWidth,
      title: 'confirm'.tr,
      onTap: con.activeBtn ? _onConfirm : () {},
      color: con.activeBtn ? null : ThemeClass.textFieldBackgroundColor,
      borderColor:
          con.activeBtn ? null : ThemeClass.textFieldBackgroundColor,
      textColor: con.activeBtn ? null : ThemeClass.hintColor,
      backgroundColor:
          con.activeBtn ? null : ThemeClass.buttonNotActiveColor,
    );
  }
}
