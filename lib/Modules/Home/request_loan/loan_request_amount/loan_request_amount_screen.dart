// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:Tanmeyah/Widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/Validator.dart';
import '../../../../Utilities/general_toast.dart';
import '../../../../Utilities/loading_screen.dart';
import 'loan_request_amount_controller.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

class LoanRequestAmountScreen extends StatefulWidget {
  static const String routeName = "/loanAmountScreen";

  const LoanRequestAmountScreen({Key? key}) : super(key: key);

  @override
  _LoanAmountScreenState createState() => _LoanAmountScreenState();
}

class _LoanAmountScreenState extends StateMVC<LoanRequestAmountScreen>
    with WidgetsBindingObserver {
  _LoanAmountScreenState() : super(LoanRequestAmountController()) {
    con = LoanRequestAmountController();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if(state == AppLifecycleState.resumed)  {
  //     await con.getCurrentPosition(context);
  //     setState(() { });
  //   }
  // }

  // @override
  // void didUpdateWidget(covariant StatefulWidget oldWidget) {
  //   con.getCurrentPosition(context);
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.logEvent(
    //     name: 'open_loan_amount_screen',
    //     parameters: <String,dynamic>{
    //       "title" :"open_loan_amount_screen"
    //     }
    // );
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if(state == AppLifecycleState.resumed){
  //     print(">>>>>>>>>>>>>>>");
  //     con.checkLocation(context);
  //   }
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    con.checkLocation(context: context, isInitLocation: false);
  }

  late LoanRequestAmountController con;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      loading: con.loading,
      child: Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(
          title: "ask_loan".tr,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: ThemeClass.whiteColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: con.formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.IMG_AMOUNT,
                            width: 300.w,
                            height: 300.h,
                          ),

                          SizedBox(
                            height: 22.h,
                          ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: "أقل قيمة للتمويل هي ",style: TextStyle(color: ThemeClass.primaryColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp)),
                              TextSpan(text: "ألف ", style:  TextStyle(fontWeight: FontWeight.bold,color: ThemeClass.primaryColor,fontSize: 16.sp,fontFamily: "DINNextLTArabic-Regular")),
                              TextSpan(text: "جنيه مصري وأقصى قيمة للتمويل هي",style: TextStyle(color: ThemeClass.primaryColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp)),
                              TextSpan(text: " ٢٢٠ ألف ", style:  TextStyle(fontWeight: FontWeight.bold,color: ThemeClass.primaryColor,fontSize: 16.sp,fontFamily: "DINNextLTArabic-Regular")),
                              TextSpan(text: "جنيه مصري",style: TextStyle(color: ThemeClass.primaryColor,fontFamily: "DINNextLTArabic-Regular",fontSize: 16.sp)),
                            ],
                          ),
                        ),
                      ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: AppTextRegular(title: "loan_amount".tr)),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFieldWidget(
                                width: 215.w,
                                height: 56.h,
                                hint: "loan_amount".tr,
                                onchange: (value) {
                                  if (value.length < 4) {
                                    con.activeBtn = false;
                                    setState(() {});
                                  } else {
                                    con.activeBtn = true;
                                    setState(() {});
                                  }
                                },
                                textInputType: TextInputType.phone,
                                controller: con.loanAmount,
                                formatter: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                validator: (value) {
                                  var regExp = RegExp("^[0-9]");
                                  if(!regExp.hasMatch(value!)) {
                                    return "يجب ادخال ارقام فقط";
                                  }
                                  return null;
                                },
                                //    var phoneRegExp = RegExp(r'^0|1[0125][0-9]{8}$');
                                // validator: (value) {
                                //   var phoneRegExp =
                                //       RegExp(r'^0|1[0125][0-9]{8}$');
                                //   if (!phoneRegExp.hasMatch(value!)) {
                                //     return "ادخل الرقم صحيح";
                                //   }
                                //   // Validator.validatePhone(context, value!)
                                // },
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Container(
                                width: 89.w,
                                height: 46.h,
                                decoration: BoxDecoration(
                                  color: ThemeClass.textfieldColor,
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(color: Colors.transparent),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ThemeClass.secondaryMediumColor,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: const Offset(
                                          -0.0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.IMG_FLAG,
                                      width: 24.w,
                                      height: 16.h,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    AppTextMedium(
                                      title: "ج م",
                                      color: ThemeClass.fontColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: con.loanAmount.text.length < 4
                          ? Column(
                              children: [
                                CustomButton(
                                  width: 216,
                                  title: "send".tr,
                                  onTap: () {},
                                  color: ThemeClass.textFieldBackgroundColor,
                                  borderColor:
                                      ThemeClass.textFieldBackgroundColor,
                                  textColor: ThemeClass.hintColor,
                                  backgroundColor:
                                      ThemeClass.buttonNotActiveColor,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                CustomButton(
                                  width: 216,
                                  title: "send".tr,
                                  backgroundColor:
                                      ThemeClass.buttonBackgroundColor,
                                  onTap: () {
                                    if (con.formKey.currentState!.validate()) {
                                      if (con.loanAmount.text.isNotEmpty &&
                                          con.loanAmount.text.length > 3) {
                                        if (con.currentPosition == null) {
                                          con.checkLocation(
                                              context: context,
                                              isInitLocation: true);
                                        } else {
                                          // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                                          // analytics.logEvent(
                                          //     name: 'submit_loan_request',
                                          //     parameters: <String,dynamic>{
                                          //       "title" :"submit_loan_request"
                                          //     }
                                          // );
                                          con.applyForLoan(context);
                                        }
                                      } else {
                                        ToastHelper.showError(context,
                                            message: "enter_amount".tr);
                                      }
                                    } else {
                                      setState(() {
                                        con.autoValidate = true;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
