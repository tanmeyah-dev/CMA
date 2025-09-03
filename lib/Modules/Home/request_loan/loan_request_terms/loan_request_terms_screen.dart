// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/Home/request_loan/loan_request_amount/loan_request_amount_screen.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/themeclass.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/general_toast.dart';
import '../../../../Utilities/loading_screen.dart';
import 'loan_request_terms_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../../../Widgets/simple_animations.dart';


class LoanRequestTermsScreen extends StatefulWidget {
  static const String routeName = "/loanTermsScreen";

  const LoanRequestTermsScreen({Key? key}) : super(key: key);

  @override
  _LoanTermsScreenState createState() => _LoanTermsScreenState();
}

class _LoanTermsScreenState extends StateMVC<LoanRequestTermsScreen> {
  _LoanTermsScreenState() : super(LoanRequestTermsController()) {
    con = LoanRequestTermsController();
  }

  late LoanRequestTermsController con;

  @override
  void initState() {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'open_loan_terms_screen',
        parameters: <String,dynamic>{
          "title" :"open_loan_terms_screen"
        }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      loading: con.loading,
      child: Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(
          title: "loan_terms".tr,
          centerTitle: false,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: ThemeClass.whiteColor,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 30.h),
                            FadeIn(
                              delay: 1,
                              from: SlideFrom.LEFT,
                              child: bannerWidget(
                                  title: "loan_term_1".tr,
                                  imageUrl: AppAssets.IMG_TERMS1),
                            ),
                            SizedBox(height: 10.h),
                            FadeIn(
                              delay: 1.5,
                              from: SlideFrom.LEFT,
                              child: bannerWidget(
                                  title: "loan_term_2".tr,
                                  imageUrl: AppAssets.IMG_TERMS2),
                            ),
                            SizedBox(height: 10.h),
                            FadeIn(
                              delay: 2,
                              from: SlideFrom.LEFT,
                              child: bannerWidget(
                                  title: "loan_term_3".tr,
                                  imageUrl: AppAssets.IMG_TERMS3),
                            ),
                            SizedBox(height: 10.h),
                            FadeIn(
                              delay: 2.5,
                              from: SlideFrom.LEFT,
                              child: bannerWidget(
                                  title: "loan_term_4".tr,
                                  imageUrl: AppAssets.IMG_TERMS4),
                            ),
                            SizedBox(height: 16.h,),
                            FadeIn(
                              delay: 2.5,
                              from: SlideFrom.LEFT,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    shape: const CircleBorder(),
                                    value: con.accept,
                                    onChanged: (value) {
                                      con.accept = !con.accept;
                                      setState(() {});
                                    },
                                    activeColor: ThemeClass.primaryColor,
                                  ),
                                  AppTextRegular(title: "accept_terms".tr),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50.h,),
                        Column(
                          children: [
                            FadeIn(
                              delay: 2.5,
                              from: SlideFrom.LEFT,
                              child: bannerWidget(
                                title: "loan_term_5".tr,
                                imageUrl: AppAssets.IMG_TERMS5,
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            FadeIn(
                              delay: 2.5,
                              from: SlideFrom.LEFT,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    shape: const CircleBorder(),
                                    value: con.accept2,
                                    onChanged: (value) {
                                      con.accept2 = !con.accept2;
                                      setState(() {});
                                    },
                                    activeColor: ThemeClass.primaryColor,
                                  ),
                                  const AppTextRegular(title: "نعم لدي مشروع قائم منذ ٦ اشهر"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FadeIn(
                    delay: 2,
                    from: SlideFrom.BOTTOM,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h,),
                          (con.accept == true && con.accept2 == true)  ?
                          CustomButton(
                              width: 216,
                              title: "start_ask_for_loan".tr, onTap: () {
                            if(con.accept) {
                              final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                              analytics.logEvent(
                                  name: 'submit_start_request_loan',
                                  parameters: <String,dynamic>{
                                    "title" :"submit_start_request_loan"
                                  }
                              );
                                Navigator.pushNamed(context, LoanRequestAmountScreen.routeName);
                            }else {
                              ToastHelper.showError(context ,message: "alert_accept_terms".tr);
                            }
                          }) : CustomButton(
                            width: 216,
                            title: "start_ask_for_loan".tr, onTap: (){},
                            color: ThemeClass.textFieldBackgroundColor,
                            borderColor: ThemeClass.textFieldBackgroundColor,
                            textColor: ThemeClass.hintColor,
                            backgroundColor: ThemeClass.buttonNotActiveColor,
                          ),
                          SizedBox(height: 16.h,),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bannerWidget({required String title, required String imageUrl}) {
    return Container(
      width: 354.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: ThemeClass.termsBackground,
      ),
      padding: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w, top: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250.w,
            child: AppTextRegular(
              fontSize: 16.sp,
              title: title,
              color: ThemeClass.fontColor,
              textAlign: TextAlign.start,
            ),
          ),
          Image.asset(
            imageUrl,
            width: 32.w,
            height: 34.h,
          ),
        ],
      ),
    );
  }
}
