// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/loan/payment_methods/payment_methods_screen.dart';
import 'package:Tanmeyah/Modules/loan/payment_needed/payment_needed_screen.dart';
import 'package:Tanmeyah/Modules/loan/previous_loans/previous_loan_screen.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../Theme/app_assets.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/general_toast.dart';
import '../../Authentication/Login/login_screen.dart';
import '../already_paid/already_paid_screen.dart';
import 'main_loan_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import '../../../../Widgets/simple_animations.dart';


class MainLoanScreen extends StatefulWidget {
  static const String routeName = "/mainLoanScreen";

  const MainLoanScreen({Key? key}) : super(key: key);

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends StateMVC<MainLoanScreen> {
  _LoanScreenState() : super(MainRequestLoanController()) {
    con = MainRequestLoanController();
  }

  late MainRequestLoanController con;

  @override
  void initState() {
    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.logEvent(
    //     name: 'open_main_loan_screen',
    //     parameters: <String,dynamic>{
    //       "title" :"open_main_loan_screen"
    //     }
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(
          title: "loan".tr,
          isBackButtonVisible: false,
        ),
        body: SafeArea(
          child: LoadingScreen(
            loading: con.loading,
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: con.isLogin
                  ? (con.activeLoanModel?.activeLoan != null)
                      ? Container(
                          padding: EdgeInsets.all(16.w),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                 Container(
                                    width: 328.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(16.sp),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              AppAssets.IMG_LOAN_BACKGROUND),
                                        )),
                                    padding: EdgeInsets.all(14.sp),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AppTextRegular(
                                          title: "current_loan".tr,
                                          fontSize: 14.sp,
                                          color: ThemeClass.whiteColor,
                                        ),
                                        AppTextBold(
                                          title: con.activeLoanModel?.activeLoan
                                              ?.totalAmount
                                              .toString() ??
                                              "0000",
                                          color: ThemeClass.accentColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 36.sp,
                                        ),
                                      ],
                                    ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column
                                            (
                                            children: [
                                              amounts(
                                                  title: "اجمالي الغرامات",
                                                  amount:
                                                  "${con.activeLoanModel?.activeLoan?.penaltyAmount.toString()}",color: const Color(0xFFEAF3EB)),
                                              SizedBox(height: 8.h),
                                              amounts(
                                                  title: "paid_value".tr,
                                                  amount:
                                                  "${con.activeLoanModel?.activeLoan?.paidAmount.toString()}",color: const Color(0xFFEAF3EB)),
                                              SizedBox(height: 8.h),
                                              amounts(
                                                  title: "loan_needed".tr,
                                                  amount:
                                                  "${con.activeLoanModel?.activeLoan?.totalDueAmount.toString()}",color : const Color(0xFFFFF3F2))
                                            ],
                                          ),
                                          Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                numberOfMonths(
                                                    title: 'paid'.tr,
                                                    months: con
                                                        .activeLoanModel
                                                        ?.activeLoan
                                                        ?.numberOfpaidMonths
                                                        .toString() ??
                                                        "0",
                                                    routeName: AlreadyPaidScreen
                                                        .routeName),
                                                SizedBox(width: 8.w),
                                                numberOfMonths(
                                                    title: 'needed'.tr,
                                                    months: con
                                                        .activeLoanModel
                                                        ?.activeLoan
                                                        ?.numberOfNotPaidMonths
                                                        .toString() ??
                                                        "0",
                                                    routeName: PaymentNeededScreen
                                                        .routeName),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            Container(
                                                width: 170.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      16.sp),
                                                  color: const Color(0xFFF0FAFF),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                    horizontal: 16.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    AppTextRegular(
                                                        title: "next_loan".tr,color: ThemeClass.borderColor,fontWeight: FontWeight.w300,),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    AppTextBold(
                                                      title: con
                                                          .activeLoanModel
                                                          ?.activeLoan
                                                          ?.nextInstallmentDate
                                                          .toString()??
                                                          "",
                                                      color:
                                                      ThemeClass.blackColor,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize: 22.sp,
                                                    ),
                                                    SizedBox(
                                                      height: 18.h,
                                                    ),
                                                    AppTextRegular(title: "installment_value".tr,color: ThemeClass.borderColor,),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    AppTextBold(title: con.activeLoanModel!.activeLoan!.dueInstallmentAmount.toString()),
                                                    SizedBox(height: 8.h)
                                                  ],
                                                )),


                                          ]),
                                        ]),
                                SizedBox(height: 8.h,),
                                CustomButton(
                                      borderColor: ThemeClass.buttonNotActiveColor,
                                      radius: 16,
                                      title: "pay_now".tr,
                                      onTap: ()  {
                                        // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                                        // analytics.logEvent(
                                        //     name: 'request_pay',
                                        //     parameters: <String,dynamic>{
                                        //       "title" :"request_pay"
                                        //     }
                                        // );
                                        Navigator.pushNamed(context, PaymentMethodsScreen.routeName,arguments: con.activeLoanModel?.activeLoan?.dueInstallmentAmount.toString());
                                      },
                                ),
                                SizedBox(height: 55.h,),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: con.activeLoanModel!.havePreviousLoan == true ?  CustomButton(title: "previous_loan".tr, onTap: (){
                                      // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                                      // analytics.logEvent(
                                      //     name: 'request_previous_loans',
                                      //     parameters: <String,dynamic>{
                                      //       "title" :"request_previous_loans"
                                      //     }
                                      // );
                                      Navigator.pushNamed(context, PreviousLoanScreen.routeName);
                                    },width: 216.w,backgroundColor: Colors.transparent, textColor: ThemeClass.primaryColor,) : Container(),
                                ),
                                SizedBox(height: 70.h,),
                              ],
                            ),
                          ),)
                      : Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
                          child: Column(
                            children: [
                              Image.asset(
                                  AppAssets.IMG_NO_LOAN,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 328.h,
                              ),
                              SizedBox(height: 20.h,),
                              AppTextRegular(title: "empty_loans".tr,fontSize: 20.sp,fontWeight: FontWeight.w500,),
                              SizedBox(height: 170.h,),
                              (con.activeLoanModel?.havePreviousLoan != null) ?
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: con.activeLoanModel?.havePreviousLoan == true ?  CustomButton(title: "previous_loan".tr, onTap: (){
                                    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                                    // analytics.logEvent(
                                    //     name: 'request_previous_loans',
                                    //     parameters: <String,dynamic>{
                                    //       "title" :"request_previous_loans"
                                    //     }
                                    // );
                                    Navigator.pushNamed(context, PreviousLoanScreen.routeName);
                                  },width: 216.w,backgroundColor: Colors.transparent, textColor: ThemeClass.primaryColor,) : Container(),
                              ) : Container()
                            ],
                          ),
                        )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Image.asset(AppAssets.IMG_EMPTY_LOAN,fit: BoxFit.fill,height: 319.h,width: 360.w,),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                       AppTextMedium(
                          title: "empty_loan".tr,
                      ),
                      SizedBox(height: 131.h,),
                       CustomButton(
                            width: 216,
                            title: "login".tr,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, LoginScreen.routeName,
                                  arguments: "");
                            },
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget amounts({required String title, required String amount,required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.w),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextRegular(title: title,color: ThemeClass.borderColor,fontWeight: FontWeight.w300,),
          SizedBox(
            height: 7.h,
          ),
          AppTextBold(
            title: amount,
            color: ThemeClass.blackColor,
          ),
          SizedBox(
            height: 14.h,
          ),
        ],
      ),
    );
  }

  Widget numberOfMonths(
      {required String title,
      required String months,
      required String routeName}) {
    return GestureDetector(
      onTap: () {
        // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
       if(routeName == AlreadyPaidScreen.routeName) {
         // analytics.logEvent(
         //     name: 'request_paid_installment_screen',
         //     parameters: <String, dynamic>{
         //       "title": "request_paid_installment_screen"
         //     }
         // );
       }else {
         // analytics.logEvent(
         //     name: 'request_due_installment_screen',
         //     parameters: <String,dynamic>{
         //       "title" :"request_due_installment_screen"
         //     }
         // );
       }
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFEFBE8),
            borderRadius: BorderRadius.circular(16.sp),
            border: Border.all(color: ThemeClass.primaryColor,width: 1.sp)
        ),
        padding: EdgeInsets.symmetric(vertical : 12.w,horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    AppTextRegular(title: title,color: ThemeClass.borderColor,fontWeight: FontWeight.w300,),
                    SizedBox(height: 5.h,)
                  ],
                ),
                SizedBox(width: 8.w,),
                Container(
                  decoration: BoxDecoration(
                    color: ThemeClass.borderColor,
                    borderRadius: BorderRadius.circular(4.sp)
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 8.sp,
                    color: const Color(0xFFFEFBE8),
                  ),
                ),
              ],
            ),
            AppTextBold(
              title: months,
              color: ThemeClass.blackColor,
            ),
            AppTextRegular(title: "installments".tr),
          ],
        ),
      ),
    );
  }
}
