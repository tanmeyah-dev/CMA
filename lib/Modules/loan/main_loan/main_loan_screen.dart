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
import 'package:firebase_analytics/firebase_analytics.dart';import 'package:iconsax/iconsax.dart';



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
  bool _isExpanded = false;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_main_loan_screen',
        parameters: <String,dynamic>{
          "title" :"open_main_loan_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(
          title: "wallet".tr,
          isBackButtonVisible: false,
        ),
        body: SafeArea(
          child: LoadingScreen(
            loading: con.loading,
            child: SingleChildScrollView(
              child:  con.isLogin
                  ? (con.activeLoanModel?.activeLoan != null)
                  ? Container(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  children: [
                    Align(alignment : Alignment.centerRight,child: AppTextRegular(title: "current_loans".tr,fontSize: 24.sp,fontWeight: FontWeight.w300,),),
                    SizedBox(height: 10.h,),
                    FadeIn(
                      delay: 1.5,
                      from: SlideFrom.RIGHT,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Container(
                            width: 328.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(16.sp),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      AppAssets.IMG_LOAN_BACKGROUND,),fit: BoxFit.fill
                                )),
                            padding: EdgeInsets.all(16.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextRegular(
                                      title: "total_loan".tr,
                                      fontSize: 14.sp,
                                      color: ThemeClass.whiteColor,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        AppTextBold(
                                          title: con.activeLoanModel?.activeLoan
                                              ?.totalAmount
                                              .toString() ??
                                              "0000",
                                          color: ThemeClass.whiteColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 36.sp,
                                        ),
                                        SizedBox(width: 4.w,),
                                        AppTextRegular(title: "ج. م",color: ThemeClass.whiteColor,fontSize: 20.sp,)
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  child: Icon( _isExpanded ?  Iconsax.arrow_square_up : Iconsax.arrow_square_down,color: ThemeClass.whiteColor,),
                                )
                              ],
                            )
                        ),
                      ),
                    ),
                    FadeIn(
                      delay: 2,
                      from: SlideFrom.RIGHT,
                      child: Container(
                        width: 400.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.sp)
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppTextRegular(title: "month_need".tr,color: ThemeClass.primaryColor,),
                                    Icon(Iconsax.arrow_square_left5,color: ThemeClass.primaryColor,size: 16.sp,)
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    AppTextBold(title: con.activeLoanModel!.activeLoan!.dueInstallmentAmount.toString()),
                                    SizedBox(width: 4.w,),
                                    AppTextRegular(title: "ج. م",color: ThemeClass.primaryColor,fontSize: 14.sp,)
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 60.w,
                              // height: 50.h,
                              decoration: BoxDecoration(
                                  color: ThemeClass.primaryColor,
                                  borderRadius: BorderRadius.circular(8.sp)
                              ),
                              padding: EdgeInsets.all(4.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.card_send,color: ThemeClass.whiteColor,),
                                  AppTextRegular(title: "pay".tr,color: ThemeClass.whiteColor,),
                                ],
                              ),
                            ),
                          ],
                        ) ,
                      ),
                    ),
                    AnimatedContainer(
                      duration:  Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      height: _isExpanded ? 340.h : 0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _isExpanded
                          ?  SingleChildScrollView(
                             child: Column(
                          children: [
                                Container(
                                  width: 366.w,
                                  decoration: BoxDecoration(
                                    color: ThemeClass.greyBackgroundColor,
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  padding: EdgeInsets.all(12.sp),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppTextRegular(title: "last_paid_amount".tr),
                                          Row(
                                            textBaseline: TextBaseline.alphabetic,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              AppTextBold(title: con.activeLoanModel?.activeLoan?.lastPaidInstallmentAmount.toString()??"0",color: ThemeClass.greenColor,fontSize: 16.sp,),
                                              SizedBox(width: 4.w,),
                                              AppTextRegular(title: "ج. م",color: ThemeClass.greenColor,fontSize: 14.sp,)
                                            ],
                                          ),
                                        ],
                                      ),

                                      SizedBox(width: 60.w,),
                                      Container(color: ThemeClass.borderColor,height: 40.h,width: 1.w,),
                                      SizedBox(width: 20.w,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextRegular(title: "date_of_pay".tr),
                                              AppTextBold(title: con.activeLoanModel?.activeLoan?.nextInstallmentDate.toString()??"0",color: ThemeClass.blackColor,fontSize: 16.sp,),
                                            ],
                                          ),
                                          SizedBox(width: 40.w,),
                                          Icon(Iconsax.arrow_square_left,color: ThemeClass.borderColor,)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                                Container(
                                  width: 366.w,
                                  decoration: BoxDecoration(
                                    color: ThemeClass.greyBackgroundColor,
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  padding: EdgeInsets.all(12.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextRegular(title: "paided".tr),
                                              AppTextBold(title: con.activeLoanModel?.activeLoan?.numberOfpaidMonths.toString()??"0",color: ThemeClass.greenColor,fontSize: 16.sp,),
                                            ],
                                          ),
                                          SizedBox(width: 40.w,),
                                          Icon(Iconsax.arrow_square_left,color: ThemeClass.borderColor,)
                                        ],
                                      ),
                                      Container(color: ThemeClass.borderColor,height: 40.h,width: 1.w,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextRegular(title: "remaining".tr),
                                              AppTextBold(title: con.activeLoanModel?.activeLoan?.numberOfNotPaidMonths.toString()??"0",color: ThemeClass.greenColor,fontSize: 16.sp,),
                                            ],
                                          ),
                                          SizedBox(width: 40.w,),
                                          Icon(Iconsax.arrow_square_left,color: ThemeClass.borderColor,)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                                Container(
                                  width: 366.w,
                                  decoration: BoxDecoration(
                                    color: ThemeClass.greyBackgroundColor,
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  padding: EdgeInsets.all(12.sp),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppTextRegular(title: "paid_amount".tr),
                                         Row(
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           textBaseline: TextBaseline.alphabetic,
                                           children: [
                                             AppTextBold(title: con.activeLoanModel?.activeLoan?.paidAmount.toString()??"0",color: ThemeClass.greenColor,fontSize: 16.sp,),
                                             SizedBox(width: 4.w,),
                                             AppTextRegular(title: "ج. م",color: ThemeClass.greenColor,fontSize: 14.sp,)
                                           ],
                                         ),
                                        ],
                                      ),
                                      SizedBox(width: 40.w,),
                                      Container(color: ThemeClass.borderColor,height: 40.h,width: 1.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppTextRegular(title: "remaining".tr),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              AppTextBold(title: con.activeLoanModel?.activeLoan?.totalDueAmount.toString()??"0",color: ThemeClass.secondaryColor,fontSize: 16.sp,),
                                              SizedBox(width: 4.w,),
                                              AppTextRegular(title: "ج. م",color: ThemeClass.secondaryColor,fontSize: 14.sp,)
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 40.w,),
                                      Container(color: ThemeClass.borderColor,height: 40.h,width: 1.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppTextRegular(title: "tex_amount".tr),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              AppTextBold(title: con.activeLoanModel?.activeLoan?.penaltyAmount.toString()??"0",color: ThemeClass.orangeColor,fontSize: 16.sp,),
                                              SizedBox(width: 4.w,),
                                              AppTextRegular(title: "ج. م",color: ThemeClass.orangeColor,fontSize: 14.sp,)
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                                Container(
                                  width: 366.w,
                                  decoration: BoxDecoration(
                                    color: ThemeClass.greyBackgroundColor,
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  padding: EdgeInsets.all(12.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextRegular(title: "next_installment".tr),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                textBaseline: TextBaseline.alphabetic,
                                                children: [
                                                  AppTextBold(title: con.activeLoanModel?.activeLoan?.paidAmount.toString()??"0",fontSize: 16.sp,),
                                                  SizedBox(width: 4.w,),
                                                  AppTextRegular(title: "ج. م",color: ThemeClass.orangeColor,fontSize: 14.sp,)
                                                ],
                                              )
                                            ],
                                          ),
                                          Icon(Iconsax.arrow_square_left,color: ThemeClass.borderColor,)
                                        ],
                                      ),
                                      Container(color: ThemeClass.borderColor,height: 30.h,width: 1.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppTextRegular(title: "due_date".tr),
                                          AppTextBold(title: con.activeLoanModel?.activeLoan?.nextInstallmentDate??"0",color: ThemeClass.blackColor,fontSize: 16.sp,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                          ],
                        ),
                      )
                          : null,
                    ),

                  ],
                ),
              )
                  : Container(
                padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
                child: Column(
                  children: [
                    FadeIn(
                      delay: 1,
                      from: SlideFrom.TOP,
                      child: Image.asset(
                        AppAssets.IMG_NO_LOAN,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 328.h,
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    FadeIn(
                        delay: 1,
                        from: SlideFrom.BOTTOM,
                        child: AppTextRegular(title: "empty_loans".tr,fontSize: 20.sp,fontWeight: FontWeight.w500,)),
                    SizedBox(height: 170.h,),
                    (con.activeLoanModel?.havePreviousLoan != null) ?
                    FadeIn(
                      delay: 1,
                      from: SlideFrom.BOTTOM,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: con.activeLoanModel?.havePreviousLoan == true ?  CustomButton(title: "previous_loan".tr, onTap: (){
                          final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                          _analytics.logEvent(
                              name: 'request_previous_loans',
                              parameters: <String,dynamic>{
                                "title" :"request_previous_loans"
                              }
                          );
                          Navigator.pushNamed(context, PreviousLoanScreen.routeName);
                        },width: 216.w,backgroundColor: Colors.transparent, textColor: ThemeClass.primaryColor,) : Container(),
                      ),
                    ) : Container()
                  ],
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FadeIn(
                    delay: 1,
                    from: SlideFrom.TOP,
                    child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Image.asset(AppAssets.IMG_EMPTY_LOAN,fit: BoxFit.fill,height: 319.h,width: 360.w,)),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  FadeIn(
                    delay: 1,
                    from: SlideFrom.TOP,
                    child: AppTextMedium(
                      title: "empty_loan".tr,
                    ),
                  ),
                  SizedBox(height: 131.h,),
                  FadeIn(
                    delay: 1,
                    from: SlideFrom.BOTTOM,
                    child: CustomButton(
                        width: 216,
                        title: "login".tr,
                        onTap: () {
                          Navigator.pushNamed(
                              context, LoginScreen.routeName,
                              arguments: "");
                        }),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }


}
