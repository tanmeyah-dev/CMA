// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, must_be_immutable
import 'package:Tanmeyah/Utilities/general_toast.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/app_assets.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/Validator.dart';
import '../../../Utilities/encreption.dart';
import '../../../Utilities/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/country_code_widget.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/skip_button.dart';
import '../ForgetPassword/forget_password_screen.dart';
import '../Register/register_screen.dart';
import 'local_auth/local_auth_api.dart';
import 'local_auth/local_auth_screen.dart';
import 'login_controller.dart';
import 'package:local_auth/local_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";
  String phoneNumber;

  LoginScreen({required this.phoneNumber, Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  _LoginScreenState() : super(LoginController()) {
    con = LoginController();
  }

  late LoginController con;

  @override
  void initState() {
    checkAvailable();
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_login_screen',
        parameters: <String,Object>{
          "title" :"open_login_screen"
        }
    );
    super.initState();
  }

  checkAvailable() async {
    final biometrics = await LocalAuthApi.getBiometric();
    con.hasFaceId = biometrics.contains(BiometricType.face);
    con.hasFingerPrint = biometrics.contains(BiometricType.strong);
    con.hasOldFaceVersion = biometrics.contains(BiometricType.weak);
    con.hasFingerPrintForIOS = biometrics.contains(BiometricType.fingerprint);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        con.hasFaceId;
        con.hasFingerPrint;
        con.hasOldFaceVersion;
        con.hasFingerPrintForIOS;
      });
    });

    print("<<<<<<<<!!!!" + con.hasFaceId.toString());
    print("<<<<<<<<!!!!" + con.hasFingerPrint.toString());
    print("<<<<<<<<!!!!" + con.hasFingerPrintForIOS.toString());


    if (widget.phoneNumber != "") {
      con.phoneController.text = widget.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: ThemeClass.whiteColor,
            extendBodyBehindAppBar: true,
            appBar: BaseAppBar.main(
                isBackButtonVisible: false,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                      padding: EdgeInsetsDirectional.only(top: 16.h, end: 30.w),
                      child: SkipButton(
                          onTap: () {
                            final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                            _analytics.logEvent(
                                name: 'skip_login_screen',
                                parameters: <String,Object>{
                                  "title" :"skip_login_screen"
                                }
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/mainScreen', (Route<dynamic> route) => false);

                            // EncryptionDecryption.encryptAES("Mohamed");

                              // EncryptionDecryption.decryptAES("9kVLhLuDOIRK+xlZOkFTUg==");
                          }
                      ))
                ]),
            body: LoadingScreen(
              loading: con.loading,
              child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.IMG_LOGIN_BACK,),fit: BoxFit.fill
                        )
                      ),
                      child: SingleChildScrollView(
                          child: Form(
                              key: con.newFormKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 186.h),
                                    image(),
                                    SizedBox(height: 100.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        AppTextRegular(title: "تسجيل",fontSize: 24.sp,fontWeight: FontWeight.w300,color: ThemeClass.secondaryColor,),
                                        SizedBox(width: 4.w,),
                                        AppTextMedium(title: "الدخول",fontSize: 24.sp,fontWeight: FontWeight.w400,color: ThemeClass.secondaryColor),
                                      ],
                                    ),
                                    SizedBox(height: 63.h),
                                    Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: AppTextRegular(
                                            title: "phone_number".tr,
                                            color: ThemeClass.secondaryColor,
                                          ),
                                    ),
                                    SizedBox(height: 10.h),
                                    phoneTxtField(),
                                     Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: AppTextRegular(
                                            title: "password".tr,
                                            color: ThemeClass.secondaryColor,
                                          )
                                    ),
                                    SizedBox(height: 10.h),
                                    passwordTxtField(context),
                                    forgetPassTxt(),
                                    SizedBox(height: 26.h),
                                    Row(
                                      mainAxisAlignment:
                                          (con.hasFingerPrint || con.hasFaceId || con.hasFingerPrintForIOS)
                                              ? MainAxisAlignment.center
                                              : MainAxisAlignment.center,
                                      children: [
                                        bioMetric(),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        loginBtn(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 35.h,
                                    ),
                                    registerTxt(),
                                  ]))))),
            )));
  }

  Widget image() {
    return Hero(tag: "gifHero", child: Image.asset(AppAssets.IMG_LOGIN_LOGO,
        height: 58.h, width: 166.w, fit: BoxFit.fitWidth));
  }

  Widget phoneTxtField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
         CustomTextFieldWidget(
                controller: con.phoneController,
                hint: "phone_number".tr,
                textInputType: TextInputType.number,
                validator: (value) => Validator.validatePhone(context, value!),
                formatter: [
                  LengthLimitingTextInputFormatter(11),
                ]),
      ],
    );
  }

  Widget passwordTxtField(BuildContext context) {
    return  CustomTextFieldWidget(
            obscure: con.showPassword,
            controller: con.passwordController,
            hint: "password".tr,
            validator: (value) =>
                Validator.validateEmpty(value!, con.passwordController.text),
            suffixIcon: GestureDetector(
              onTap: () {
                con.showPassword = !con.showPassword;
                setState(() {});
              },
              child: Icon(
                con.showPassword ? Iconsax.eye4 : Iconsax.eye_slash5,
                color: ThemeClass.secondaryColor,
              ),
            ));
  }

  Widget forgetPassTxt() {
    return Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AppTextUnderline(
              onTap: () {
                final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                 _analytics.logEvent(
                    name: 'request_forget_password',
                    parameters: <String,Object>{
                      "title" :"request_forget_password"
                    }
                );
                Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
              },
              title: 'forget_password'.tr,
              fontSize: 14.sp,
              color: const Color(0xFF979797),
            ));
  }

  Widget loginBtn() {
    return CustomButton(
            width: 230,
            title: "login".tr,
            onTap: () async {
              if (con.newFormKey.currentState!.validate()) {
                final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                 _analytics.logEvent(
                    name: 'submit_login_screen',
                    parameters: <String,Object>{
                      "title" :"submit_login_screen"
                    }
                );
                con.logIn(context);
              } else {
                setState(() {
                  con.autoValidate = true;
                });
              }
            });
  }

  Widget orTxt() {
    return  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 100.w, height: 1.h, color: ThemeClass.fontColor),
          AppTextRegular(title: " ${"or".tr}   "),
          Container(width: 100.w, height: 1.h, color: ThemeClass.fontColor)
        ]);
  }

  Widget bioMetric() {
    return Row(
            mainAxisAlignment: (con.hasFaceId || con.hasFingerPrint || con.hasFingerPrintForIOS)
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: [
              (con.hasFingerPrint || con.hasFingerPrintForIOS)
                  ? GestureDetector(
                      onTap: () async {
                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                        _analytics.logEvent(
                            name: 'request_biometric_login_screen',
                            parameters: <String,Object>{
                              "title" :"request_biometric_login_screen"
                            }
                        );
                        bool result = await con.getBiometricsData();
                        if (!result) {
                          Navigator.pushNamed(
                              context, LocalAuthScreen.routeName);
                        } else {
                          final isAuthenticated =
                              await LocalAuthApi.authenticate();
                          if (isAuthenticated) {
                            setState(() {
                              con.phoneController.text = con.encryptedPhone!;
                              con.passwordController.text =
                                  con.encryptedPassword!;
                            });
                            final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                            _analytics.logEvent(
                                name: 'submit_biometric_login_screen',
                                parameters: <String,Object>{
                                  "title" :"submit_biometric_login_screen"
                                }
                            );
                            con.logIn(context);
                          }
                        }
                      },
                      child: Container(
                        width: 52.w,
                        height: 52.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(24.w),
                            border: Border.all(color: ThemeClass.primaryColor),
                            color: ThemeClass.primaryColor),
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset(
                          AppAssets.IMG_FINGERPRINT,
                          color: ThemeClass.whiteColor,
                          width: 30.w,
                          height: 30.h,
                        ),
                      )):
              (con.hasFaceId || con.hasOldFaceVersion) ? GestureDetector(
                      onTap: () async {
                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                        _analytics.logEvent(
                            name: 'request_biometric_login_screen',
                            parameters: <String,Object>{
                              "title" :"request_biometric_login_screen"
                            }
                        );
                        bool result = await con.getBiometricsData();
                        if (!result) {
                          Navigator.pushNamed(
                              context, LocalAuthScreen.routeName);
                        } else {
                          final isAuthenticated =
                              await LocalAuthApi.authenticate();
                          if (isAuthenticated) {
                            setState(() {
                              con.phoneController.text = con.encryptedPhone!;
                              con.passwordController.text =
                                  con.encryptedPassword!;
                            });
                            final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                            _analytics.logEvent(
                                name: 'submit_biometric_login_screen',
                                parameters: <String,Object>{
                                  "title" :"submit_biometric_login_screen"
                                }
                            );
                            con.logIn(context);
                          }
                        }
                      },
                      child: Container(
                        width: 52.w,
                        height: 52.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ThemeClass.primaryColor),
                            color: ThemeClass.primaryColor),
                        padding: EdgeInsets.all(12.w),
                        child: Image.asset(
                          AppAssets.IMG_FACE_ID,
                          color: ThemeClass.whiteColor,
                          width: 20.w,
                          height: 20.h,
                        ),
                      )):SizedBox.shrink(),
            ]);
  }

  Widget registerTxt() {
    return  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppTextRegular(
            title: "${"no_account".tr}    ",
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: const Color(0xFF979797),
          ),
          AppTextUnderline(
              title: "create_account".tr,
              onTap: () {
                final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                _analytics.logEvent(
                    name: 'request_registration_screen',
                    parameters: <String,Object>{
                      "title" :"request_registration_screen"
                    }
                );
                Navigator.pushNamed(context, RegisterScreen.routeName,
                    arguments: "");
              },
              color: ThemeClass.primaryColor,
              fontWeight: FontWeight.w700)
        ]);
  }
}
