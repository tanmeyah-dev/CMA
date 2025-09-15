// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:Tanmeyah/Modules/loan/previous_loans/previous_loan_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class PreviousLoanScreen extends StatefulWidget {
  static const String routeName = "/previousLoanScreen";

  const PreviousLoanScreen({Key? key}) : super(key: key);

  @override
  _AlreadyPaidScreenState createState() => _AlreadyPaidScreenState();
}

class _AlreadyPaidScreenState extends StateMVC<PreviousLoanScreen> {
  _AlreadyPaidScreenState() : super(PreviousLoanController()) {
    con = PreviousLoanController();
  }

  late PreviousLoanController con;

  @override
  void initState() {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'open_previous_loans_screen',
        parameters: <String,dynamic>{
          "title" :"open_previous_loans_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "التمويلات السابقة",
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: LoadingScreen(
          loading: con.loading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: ThemeClass.whiteColor,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                (con.previousLoanResponse?.historicalDataBodies != null && con.previousLoanResponse!.historicalDataBodies.isNotEmpty) ?
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return Container(
                          width: 328.w,
                          decoration: BoxDecoration(
                            color: ThemeClass.termsBackground,
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 24.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextRegular(
                                    title: "مبلغ التمويل:",
                                    color: ThemeClass.secondaryColor,
                                  ),
                                  Row(
                                    children: [
                                      AppTextBold(
                                          title:
                                          "${con.previousLoanResponse?.historicalDataBodies[index].approve}"),
                                      SizedBox(width: 4.w,),
                                      AppTextRegular(title: "egp".tr,color: ThemeClass.primaryColor,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              const Divider(),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextRegular(
                                    title: "تاريخ المنح :",
                                    color: ThemeClass.secondaryColor,
                                  ),
                                  AppTextRegular(
                                    title:
                                    con.previousLoanResponse?.historicalDataBodies[index].busDate ?? "",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: ThemeClass.borderColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              const Divider(),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextRegular(
                                    title: "تاريخ الاغلاق :",
                                    color: ThemeClass.secondaryColor,
                                  ),
                                  AppTextRegular(
                                    title:
                                    "${con.previousLoanResponse?.historicalDataBodies[index].expDate}"
                                        .substring(0, 10),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: ThemeClass.borderColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),

                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                      itemCount:
                      con.previousLoanResponse!.historicalDataBodies.length),
                ) : Container(),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
