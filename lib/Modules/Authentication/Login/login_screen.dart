// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, must_be_immutable
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:Tanmeyah/Widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/app_assets.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/Validator.dart';
import '../../../Utilities/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/country_code_widget.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/skip_button.dart';
import '../ForgetPassword/forget_password_screen.dart';
import '../Register/register_screen.dart';
import 'login_controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";
  String phoneNumber;

  LoginScreen({required this.phoneNumber, super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  _LoginScreenState() : super(LoginController()) {
    con = controller as LoginController;
  }

  late LoginController con;

  @override
  void initState() {
    super.initState();
    con.setupSession(phoneNumberArg: widget.phoneNumber);
    con.initBiometrics();
    _logAnalytics('open_login_screen');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      con.updateCanSubmit(context);
    });
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  Future<void> _onLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    _logAnalytics('submit_login_screen');
    await con.login(context);
  }

  PreferredSizeWidget _buildLoginAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SkipButton(
                  onTap: () {
                    _logAnalytics('skip_login_screen');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/mainScreen',
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 1.sw - 64.w;
    final view = View.of(context);
    final screenHeight = view.physicalSize.height / view.devicePixelRatio;
    final screenWidth = view.physicalSize.width / view.devicePixelRatio;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: _buildLoginAppBar(),
        body: LoadingScreen(
          loading: con.loading,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  width: screenWidth,
                  height: screenHeight,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.IMG_LOGIN_BACK),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(
                    left: 32.w,
                    right: 32.w,
                    bottom: keyboardInset + 24.h,
                  ),
                  child: Form(
                    key: con.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 186.h),
                        image(),
                        SizedBox(height: 100.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppTextRegular(
                              title: "تسجيل",
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w300,
                              color: ThemeClass.secondaryColor,
                            ),
                            SizedBox(width: 4.w),
                            AppTextMedium(
                              title: "الدخول",
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeClass.secondaryColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 63.h),
                        AppTextRegular(
                          title: "phone_number".tr,
                          color: ThemeClass.secondaryColor,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 10.h),
                        phoneTxtField(),
                        SizedBox(height: 10.h),
                        AppTextRegular(
                          title: "password".tr,
                          color: ThemeClass.secondaryColor,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 10.h),
                        passwordTxtField(),
                        forgetPassTxt(),
                        SizedBox(height: 26.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            bioMetric(),
                            if (con.hasBiometric) SizedBox(width: 8.w),
                            loginBtn(buttonWidth),
                          ],
                        ),
                        SizedBox(height: 35.h),
                        registerTxt(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Center(
      child: Hero(
        tag: "gifHero",
        child: Image.asset(
          AppAssets.IMG_LOGIN_LOGO,
          height: 58.h,
          width: 166.w,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget phoneTxtField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomTextFieldWidget(
        width: double.infinity,
        controller: con.phoneController,
        hint: '1xxxxxxxxx',
        textInputType: TextInputType.phone,
        textAlign: TextAlign.right,
        backGroundColor: ThemeClass.whiteColor,
        onchange: (value) => con.updateCanSubmit(context),
        validator: (value) => Validator.validatePhone(context, value),
        formatter: [
          LengthLimitingTextInputFormatter(11),
        ],
        prefixIcon: const CountryCodeWidget(inline: true),
        prefixIconConstraints: BoxConstraints(
          minWidth: 88.w,
          minHeight: 48.h,
        ),
      ),
    );
  }

  Widget passwordTxtField() {
    return CustomTextFieldWidget(
      width: double.infinity,
      obscure: con.showPassword,
      controller: con.passwordController,
      hint: "password".tr,
      onchange: (_) => con.updateCanSubmit(context),
      validator: (value) =>
          Validator.validateEmpty(value!, "password".tr),
      suffixIcon: GestureDetector(
        onTap: () {
          con.showPassword = !con.showPassword;
          setState(() {});
        },
        child: Icon(
          con.showPassword ? Iconsax.eye4 : Iconsax.eye_slash5,
          color: con.passwordController.text.isEmpty
              ? ThemeClass.hintColor
              : ThemeClass.secondaryColor,
        ),
      ),
    );
  }

  Widget forgetPassTxt() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: AppTextUnderline(
        onTap: () {
          _logAnalytics('request_forget_password');
          Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
        },
        title: 'forget_password'.tr,
        fontSize: 14.sp,
        color: const Color(0xFF979797),
      ),
    );
  }

  Widget loginBtn(double buttonWidth) {
    return CustomButton(
      width: con.hasBiometric ? 230 : buttonWidth,
      title: "login".tr,
      onTap: con.canSubmit ? _onLogin : () {},
      color: con.canSubmit ? null : ThemeClass.textFieldBackgroundColor,
      borderColor:
          con.canSubmit ? null : ThemeClass.textFieldBackgroundColor,
      textColor: con.canSubmit ? null : ThemeClass.hintColor,
      backgroundColor:
          con.canSubmit ? null : ThemeClass.buttonNotActiveColor,
    );
  }

  Widget bioMetric() {
    if (con.showFingerprint) {
      return _biometricButton(
        asset: AppAssets.IMG_FINGERPRINT,
        padding: 10.w,
        iconSize: 30,
      );
    }
    if (con.showFaceId) {
      return _biometricButton(
        asset: AppAssets.IMG_FACE_ID,
        padding: 12.w,
        iconSize: 20,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _biometricButton({
    required String asset,
    required double padding,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () => con.biometricLogin(context),
      child: Container(
        width: 52.w,
        height: 52.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ThemeClass.primaryColor),
          color: ThemeClass.primaryColor,
        ),
        padding: EdgeInsets.all(padding),
        child: Image.asset(
          asset,
          color: ThemeClass.whiteColor,
          width: iconSize.w,
          height: iconSize.h,
        ),
      ),
    );
  }

  Widget registerTxt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextRegular(
          title: "${"no_account".tr}    ",
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
          color: const Color(0xFF979797),
        ),
        AppTextUnderline(
          title: "create_account".tr,
          onTap: () {
            _logAnalytics('request_registration_screen');
            Navigator.pushNamed(
              context,
              RegisterScreen.routeName,
              arguments: "",
            );
          },
          color: ThemeClass.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
