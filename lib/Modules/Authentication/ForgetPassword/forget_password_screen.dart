// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forgetpassword_steps/forget_password_step_three.dart';
import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forgetpassword_steps/forget_password_step_two.dart';
import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/stepper.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import 'forget_password_controller.dart';
import 'forgetpassword_steps/forget_password_step_one.dart';import 'package:firebase_analytics/firebase_analytics.dart';
import '../../../Widgets/simple_animations.dart';


class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "/forgetPassword";

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends StateMVC<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  _ForgetPasswordScreenState() : super(ForgetPasswordController()) {
    con = ForgetPasswordController();
  }

  late ForgetPasswordController con;

  @override
  void initState() {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'open_forget_password_screen',
        parameters: <String,dynamic>{
          "title" :"open_forget_password_screen"
        }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(
          title: "reset_password".tr,
          isBackButtonVisible: con.stepThreeSuccess ? false : true,
        ),
        body: LoadingScreen(
          loading: con.loading,
          child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      SizedBox(height: 16.h),
                      FadeIn(
                          delay: 1.5,
                          from: SlideFrom.TOP,
                          child: StepperWidget(con: con)),
                      SizedBox(height: 16.h),
                      image(),
                          SizedBox(height: 20.h,),
                          con.stepOne ? ForgetPasswordStepOne(con : con) : Container(),
                          con.stepTwo ? ForgetPasswordStepTwo(con: con) : Container(),
                          con.stepThree ? ForgetPasswordStepThree(con: con) : Container(),
                          con.stepThreeSuccess ? successChangePassword() : Container(),
                    ]),
                  ))),
        ));
  }

  Widget image() {
    return FadeIn(
        delay: 1.5,
        from: con.stepThreeSuccess ? SlideFrom.BOTTOM : SlideFrom.TOP,
        child: Image.asset(
            con.stepThreeSuccess
                ? AppAssets.IMG_SUCCESS
                : AppAssets.IMG_FORGETPASSWORD,
            height: 300.h,
            width: 300.w,
            fit: BoxFit.fill));
  }

  // Widget stepOne() {
  //   return Form(
  //       key: con.formKey,
  //       child: SizedBox(
  //           height: 330.h,
  //           child: Column(children: [
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   FadeIn(
  //                     delay: 1.5,
  //                     from: SlideFrom.TOP,
  //                     child: AppTextRegular(
  //                       title: "id_num".tr,
  //                       color: ThemeClass.secondaryColor,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 12.h,
  //                   ),
  //                   FadeIn(
  //                       delay: 1.5,
  //                       from: SlideFrom.TOP,
  //                       child: CustomTextFieldWidget(
  //                           controller: con.nationalIdController,
  //                           hint: "id_num".tr,
  //                           onchange: (value) {
  //                             if (value.length == 14) {
  //                               con.activeBtn1 = true;
  //                             } else {
  //                               con.activeBtn1 = false;
  //                             }
  //                             setState(() {});
  //                           },
  //                           textInputType: TextInputType.phone,
  //                           validator: (value) =>
  //                               Validator.validateNationalId(context,value!),
  //                           formatter: [LengthLimitingTextInputFormatter(14)])),
  //                   SizedBox(height: 10.h),
  //                   FadeIn(
  //                     delay: 2,
  //                     from: SlideFrom.TOP,
  //                     child: AppTextRegular(
  //                       title: "phone_number".tr,
  //                       color: ThemeClass.secondaryColor,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10.h,
  //                   ),
  //                   Row(
  //                     children: [
  //                       FadeIn(
  //                           delay: 2,
  //                           from: SlideFrom.TOP,
  //                           child: CustomTextFieldWidget(
  //                               width: 215.w,
  //                               controller: con.phoneController,
  //                               hint: "phone_number".tr,
  //                               textInputType: TextInputType.phone,
  //                               onchange: (value) {
  //                                 if (value.length == 11) {
  //                                   con.activeBtn12 = true;
  //                                 } else {
  //                                   con.activeBtn12 = false;
  //                                 }
  //                                 setState(() {});
  //                               },
  //                               validator: (value) =>
  //                                   Validator.validatePhone(context,value!),
  //                               formatter: [
  //                                 LengthLimitingTextInputFormatter(11)
  //                               ])),
  //                       SizedBox(
  //                         width: 8.w,
  //                       ),
  //                       const FadeIn(
  //                           delay: 2,
  //                           from: SlideFrom.TOP,
  //                           child: CountryCodeWidget()),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             // SizedBox(height: 100.h),
  //             Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Column(
  //                   children: [
  //                     FadeIn(
  //                         delay: 2,
  //                         from: SlideFrom.BOTTOM,
  //                         child: Column(
  //                           children: [
  //                             (con.activeBtn1 == true &&
  //                                 con.activeBtn12 == true)
  //                                 ? CustomButton(
  //                                 width: 200.w,
  //                                 title: "continue".tr,
  //                                 onTap: () async {
  //                                   if (con.formKey.currentState!.validate()) {
  //                                     con.firstStep(context);
  //                                   }
  //                                 })
  //                                 : CustomButton(
  //                               width: 200.w,
  //                               title: "continue".tr,
  //                               onTap: () async {},
  //                               color: ThemeClass.textFieldBackgroundColor,
  //                               borderColor:
  //                               ThemeClass.textFieldBackgroundColor,
  //                               textColor: ThemeClass.hintColor,
  //                               backgroundColor:
  //                               ThemeClass.buttonNotActiveColor,
  //                             ),
  //                             SizedBox(height: 30.h,),
  //                           ],
  //                         )),
  //                     SizedBox(height:10.h,)
  //                   ],
  //                 ))
  //           ])));
  // }

  // Widget stepTwo() {
  //   return Form(
  //     key: con.formKey2,
  //     child: SizedBox(
  //       height: 330.h,
  //       child: Column(
  //         children: [
  //           Expanded(child: Column(
  //             children: [
  //               FadeIn(
  //                 delay: 2,
  //                 from: SlideFrom.LEFT,
  //                 child: AppTextMedium(
  //                   title: "confirm_number".tr,
  //                 ),
  //               ),
  //               SizedBox(height: 8.h),
  //               RichText(
  //                 textAlign: TextAlign.center,
  //                 text: TextSpan(
  //                   style: TextStyle(
  //                     fontSize: 14.sp,
  //                     color: Colors.black,
  //                   ),
  //                   children: <TextSpan>[
  //                     TextSpan(text: "otp_des".tr),
  //                     TextSpan(text: "  ${con.phoneController.text.substring(9)}**", style: const TextStyle(fontWeight: FontWeight.bold)),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 10.h),
  //               FadeIn(
  //                   delay: 2,
  //                   from: SlideFrom.LEFT,
  //                   child: PinCodeWidget(
  //                     controller: con.codeController,
  //                     onChangeOTP: (value) {
  //                       if (value.length == 5) {
  //                         con.activeBtn2 = true;
  //                         setState(() {});
  //                       } else {
  //                         con.activeBtn2 = false;
  //                         setState(() {});
  //                       }
  //                     },
  //                   )),
  //               SizedBox(height: 20.h),
  //               FadeIn(
  //                   delay: 1.0,
  //                   from: SlideFrom.LEFT,
  //                   child:
  //                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //                     InkWell(
  //                         onTap: () {
  //                           if (con.activeResend == true) {
  //                             con.onResendCode(context);
  //                           }
  //                         },
  //                         child: Text("send_again".tr,
  //                             style: TextStyle(
  //                                 decoration: TextDecoration.underline,
  //                                 fontWeight: con.activeResend
  //                                     ? FontWeight.w600
  //                                     : FontWeight.w400,
  //                                 fontSize: 16.sp,
  //                                 color: con.activeResend
  //                                     ? ThemeClass.blackColor
  //                                     : ThemeClass.fontColor))),
  //                     Text(" ${con.start} ${"seconds".tr}",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 14.sp,
  //                             color: ThemeClass.blackColor))
  //                   ])),
  //             ],
  //           )),
  //           FadeIn(
  //               delay: 1.5,
  //               from: SlideFrom.LEFT,
  //               child: Column(
  //                 children: [
  //                   con.activeBtn2
  //                       ? CustomButton(
  //                       width: 200.w,
  //                       title: "confirm".tr,
  //                       onTap: () {
  //                         con.secondStep(context);
  //                       })
  //                       : CustomButton(
  //                     width: 200.w,
  //                     title: "confirm".tr,
  //                     onTap: () {},
  //                     color: ThemeClass.textFieldBackgroundColor,
  //                     borderColor: ThemeClass.textFieldBackgroundColor,
  //                     textColor: ThemeClass.hintColor,
  //                     backgroundColor: ThemeClass.buttonNotActiveColor,
  //                   ),
  //                   SizedBox(height: 40.h,)
  //                 ],
  //               ))
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget stepThree() {
  //   return Form(
  //       key: con.formKey3,
  //       child: SizedBox(
  //         height: 330.h,
  //         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //           Expanded(child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               FadeIn(
  //                 delay: 1,
  //                 from: SlideFrom.LEFT,
  //                 child: AppTextRegular(
  //                   title: "new_password".tr,
  //                   color: ThemeClass.secondaryColor,
  //                 ),
  //               ),
  //               SizedBox(height: 10.h),
  //               FadeIn(
  //                   delay: 0.5,
  //                   from: SlideFrom.LEFT,
  //                   child: CustomTextFieldWidget(
  //                       onchange: (value) {
  //                         if (value.length > 8) {
  //                           con.activeBtn31 = true;
  //                         } else {
  //                           con.activeBtn31 = false;
  //                         }
  //                       },
  //                       obscure: con.showNewPassword,
  //                       controller: con.newPasswordController,
  //                       hint: "new_password".tr,
  //                       textInputType: TextInputType.text,
  //                       validator: (value) => Validator.validatePassword(context,value!))),
  //               SizedBox(height: 10.h),
  //               FadeIn(
  //                 delay: 1,
  //                 from: SlideFrom.LEFT,
  //                 child: AppTextRegular(
  //                   title: "confirm_new_password".tr,
  //                   color: ThemeClass.secondaryColor,
  //                 ),
  //               ),
  //               SizedBox(height: 10.h),
  //               FadeIn(
  //                   delay: 1,
  //                   from: SlideFrom.LEFT,
  //                   child: CustomTextFieldWidget(
  //                       obscure: con.showConfirmPassword,
  //                       controller: con.confirmNewPasswordController,
  //                       hint: "confirm_new_password".tr,
  //                       textInputType: TextInputType.text,
  //                       onchange: (value) {
  //                         if (value.length > 8) {
  //                           con.activeBtn32 = true;
  //                         } else {
  //                           con.activeBtn32 = false;
  //                         }
  //                       },
  //                       validator: (value) => Validator.matchPasswords(context,
  //                           con.newPasswordController.text,
  //                           con.confirmNewPasswordController.text))),
  //           ],),),
  //           FadeIn(
  //               delay: 1.5,
  //               from: SlideFrom.BOTTOM,
  //               child: Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Column(
  //                   children: [
  //                      // (con.activeBtn32 == true) ?
  //                     CustomButton(
  //                       width: 200.w,
  //                       title: "reset".tr,
  //                       onTap: () async {
  //                         if (con.formKey3.currentState!.validate()) {
  //                           con.thirdStep(context);
  //                         }
  //                       },
  //                     ),
  //                     //     :
  //                     // CustomButton(
  //                     //   width: 200.w,
  //                     //   title: "reset".tr,
  //                     //   onTap: () {},
  //                     //   color: ThemeClass.textFieldBackgroundColor,
  //                     //   borderColor: ThemeClass.textFieldBackgroundColor,
  //                     //   textColor: ThemeClass.hintColor,
  //                     //   backgroundColor: ThemeClass.buttonNotActiveColor,
  //                     // ),
  //                     SizedBox(height: 40.h,),
  //                   ],
  //                 ),
  //               )
  //           ),
  //          ]),
  //       ));
  // }

  Widget successChangePassword() {
    return Column(
      children: [
        FadeIn(
            delay: 1.5,
            from: SlideFrom.BOTTOM,
            child: AppTextBold(
              title: "done".tr,
              color: ThemeClass.secondaryColor,
              fontSize: 24.sp,
            )),
        SizedBox(
          height: 30.h,
        ),
        FadeIn(
            delay: 1.5,
            from: SlideFrom.BOTTOM,
            child: AppTextRegular(
              title: "success_des".tr,
              fontSize: 20.sp,
              color: ThemeClass.primaryColor,
            )),
        SizedBox(
          height: 30.h,
        ),
        FadeIn(
          delay: 1.5,
          from: SlideFrom.BOTTOM,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: AppTextHint(
                title: "success_des_2".tr,
              )),
        ),
        SizedBox(
          height: 50.h,
        ),
        FadeIn(
          delay: 1.5,
          from: SlideFrom.BOTTOM,
          child: CustomButton(
              width: 216.w,
              title: "login".tr,
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/loginScreen', (Route<dynamic> route) => false,
                    arguments: "");
              }),
        ),
      ],
    );
  }
}
