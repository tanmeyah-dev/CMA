// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forgetpassword_steps/forget_password_step_three.dart';
import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forgetpassword_steps/forget_password_step_two.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Theme/themeclass.dart';
import '../../../Utilities/helper.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import '../Login/login_screen.dart';
import 'forget_password_controller.dart';
import 'forgetpassword_steps/forget_password_step_one.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgetPassword';

  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends StateMVC<ForgetPasswordScreen> {
  _ForgetPasswordScreenState() : super(ForgetPasswordController()) {
    con = controller as ForgetPasswordController;
  }

  late ForgetPasswordController con;

  @override
  void initState() {
    super.initState();
    con.resetForm();
    _logAnalytics('open_forget_password_screen');
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  bool get _canSubmit {
    switch (con.currentStep) {
      case ForgetPasswordStep.identity:
        return con.canSubmitIdentity;
      case ForgetPasswordStep.otp:
        return con.canSubmitOtp;
      case ForgetPasswordStep.newPassword:
        return true;
      case ForgetPasswordStep.success:
        return true;
    }
  }

  String get _actionTitle {
    switch (con.currentStep) {
      case ForgetPasswordStep.identity:
        return 'continue'.tr;
      case ForgetPasswordStep.otp:
        return 'confirm'.tr;
      case ForgetPasswordStep.newPassword:
        return 'reset'.tr;
      case ForgetPasswordStep.success:
        return 'login'.tr;
    }
  }

  Future<void> _onAction() async {
    FocusManager.instance.primaryFocus?.unfocus();

    switch (con.currentStep) {
      case ForgetPasswordStep.identity:
        if (con.formKey.currentState?.validate() == true) {
          await con.firstStep(context);
        }
        break;
      case ForgetPasswordStep.otp:
        await con.secondStep(context);
        break;
      case ForgetPasswordStep.newPassword:
        if (con.formKey3.currentState?.validate() == true) {
          await con.thirdStep(context);
        }
        break;
      case ForgetPasswordStep.success:
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.routeName,
          (Route<dynamic> route) => false,
          arguments: '',
        );
        break;
    }
  }

  Widget _headerImage({required bool keyboardVisible}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: keyboardVisible ? 180.h : 300.h,
      width: keyboardVisible ? 180.w : 300.w,
      child: Image.asset(
        con.isSuccess ? AppAssets.IMG_SUCCESS : AppAssets.IMG_FORGETPASSWORD,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _description() {
    switch (con.currentStep) {
      case ForgetPasswordStep.identity:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            'forget_password_des'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeClass.borderColor,
              fontFamily: 'DINNextLTArabic-Regular',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        );
      case ForgetPasswordStep.otp:
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
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
        );
      case ForgetPasswordStep.newPassword:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            'forget_password_new_des'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeClass.borderColor,
              fontFamily: 'DINNextLTArabic-Regular',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        );
      case ForgetPasswordStep.success:
        return Column(
          children: [
            AppTextBold(
              title: 'done'.tr,
              color: ThemeClass.secondaryColor,
              fontSize: 24.sp,
            ),
            SizedBox(height: 16.h),
            AppTextRegular(
              title: 'success_des'.tr,
              fontSize: 18.sp,
              color: ThemeClass.primaryColor,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppTextHint(title: 'success_des_2'.tr),
            ),
          ],
        );
    }
  }

  Widget _currentStepFields() {
    switch (con.currentStep) {
      case ForgetPasswordStep.identity:
        return ForgetPasswordStepOne(
          con: con,
          onChanged: () => setState(() {}),
        );
      case ForgetPasswordStep.otp:
        return ForgetPasswordStepTwo(
          con: con,
          onChanged: () => setState(() {}),
        );
      case ForgetPasswordStep.newPassword:
        return ForgetPasswordStepThree(
          con: con,
          onChanged: () => setState(() {}),
        );
      case ForgetPasswordStep.success:
        return const SizedBox.shrink();
    }
  }

  Widget _actionButton(double buttonWidth) {
    return CustomButton(
      width: buttonWidth,
      title: _actionTitle,
      onTap: _canSubmit ? _onAction : () {},
      color: _canSubmit ? null : ThemeClass.textFieldBackgroundColor,
      borderColor: _canSubmit ? null : ThemeClass.textFieldBackgroundColor,
      textColor: _canSubmit ? null : ThemeClass.hintColor,
      backgroundColor: _canSubmit ? null : ThemeClass.buttonNotActiveColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final keyboardVisible = keyboardInset > 0;
    final horizontalPadding = 30.w;
    final buttonWidth = 1.sw - 60.w;

    return LoadingScreen(
      loading: con.loading,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ThemeClass.whiteColor,
          resizeToAvoidBottomInset: false,
          appBar: BaseAppBar.main(
            title: 'reset_password'.tr,
            isBackButtonVisible: !con.isSuccess,
            context: context,
            enableNotification: false,
            centerTitle: false,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      _headerImage(keyboardVisible: keyboardVisible),
                      SizedBox(height: 20.h),
                      _description(),
                      if (!con.isSuccess) ...[
                        SizedBox(height: 32.h),
                        _currentStepFields(),
                      ],
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16.h,
                  horizontalPadding,
                  keyboardVisible ? keyboardInset + 12.h : 20.h,
                ),
                child: _actionButton(buttonWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
