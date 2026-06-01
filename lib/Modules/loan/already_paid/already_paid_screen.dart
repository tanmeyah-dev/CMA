// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'already_paid_controller.dart';
import 'package:iconsax/iconsax.dart'; // <------------ import iconsax

class AlreadyPaidScreen extends StatefulWidget {
  static const String routeName = "/alreadyPaidScreen";

  const AlreadyPaidScreen({Key? key}) : super(key: key);

  @override
  _AlreadyPaidScreenState createState() => _AlreadyPaidScreenState();
}

class _AlreadyPaidScreenState extends StateMVC<AlreadyPaidScreen> {
  _AlreadyPaidScreenState() : super(AlreadyPaidController()) {
    con = AlreadyPaidController();
  }

  late AlreadyPaidController con;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_already_paid_screen',
        parameters: <String,Object>{
          "title" :"open_already_paid_screen"
        }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "already_paid".tr,
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
                (con.paidInstallmentResponse?.paidInstallment != null && con.paidInstallmentResponse!.paidInstallment!.isNotEmpty) ?
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
                                children: [
                                   Icon(Iconsax.calendar5,color: ThemeClass.monthColor,),
                                  SizedBox(
                                    width: 11.w,
                                  ),
                                  AppTextRegular(
                                    title:
                                        "شهر ${con.paidInstallmentResponse?.paidInstallment![index].month ?? ""}",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeClass.monthColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextRegular(
                                    title: "installment_amount".tr,
                                    color: ThemeClass.secondaryColor,
                                  ),
                                  Row(
                                    children: [
                                      AppTextBold(
                                          title:
                                              "${con.paidInstallmentResponse?.paidInstallment![index].instalmentAmount}"),
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
                                    title: "payment_method".tr,
                                    color: ThemeClass.secondaryColor,
                                  ),
                                  SizedBox(
                                    width : 170.w,
                                    child: AppTextRegular(
                                      title:
                                          con.paidInstallmentResponse!.paidInstallment![index].paymentMethod ?? "",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: ThemeClass.borderColor,
                                      textAlign: TextAlign.left,
                                    ),
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
                                    title: "date_of_pay".tr,
                                    color: ThemeClass.secondaryColor,
                                  ),
                                  AppTextRegular(
                                    title:
                                        "${con.paidInstallmentResponse!.paidInstallment![index].dateOfPayment}"
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
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextRegular(
                                    title: "num_of_trans".tr,
                                    color: ThemeClass.secondaryColor,
                                  ),
                                  AppTextRegular(
                                    title:
                                        "${con.paidInstallmentResponse!.paidInstallment![index].numberOfTransaction}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: ThemeClass.borderColor,
                                  ),
                                ],
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
                          con.paidInstallmentResponse!.paidInstallment!.length),
                ) : Expanded(child: Center(
                  child: AppTextBold(title: "no_services".tr,),
                )),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
