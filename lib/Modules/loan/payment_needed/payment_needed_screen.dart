// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/loan/payment_needed/payment_needed_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class PaymentNeededScreen extends StatefulWidget {
  static const String routeName = "/paymentNeeded";

  const PaymentNeededScreen({Key? key}) : super(key: key);

  @override
  _PaymentNeededScreenState createState() => _PaymentNeededScreenState();
}

class _PaymentNeededScreenState extends StateMVC<PaymentNeededScreen> {
  _PaymentNeededScreenState() : super(PaymentNeededController()) {
    con = PaymentNeededController();
  }

  late PaymentNeededController con;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_payment_needed_screen',
        parameters: <String,dynamic>{
          "title" :"open_payment_needed_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "need_to_paid".tr,
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
                (con.dueInstallmentResponse?.dueInstallments != null &&
                        con.dueInstallmentResponse!.dueInstallments!.isNotEmpty)
                    ? Expanded(
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 328.w,
                              decoration: BoxDecoration(
                                color: ThemeClass.needToPayBackground,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppTextBold(
                                              title: con
                                                  .dueInstallmentResponse!
                                                  .dueInstallments![index]
                                                  .instalmentAmount
                                                  .toString()),
                                          AppTextRegular(
                                            title: "egp".tr,
                                            color: ThemeClass.primaryColor,
                                          ),
                                        ],
                                      ),
                                      AppTextRegular(
                                          title: con
                                              .dueInstallmentResponse!
                                              .dueInstallments![index]
                                              .installmentDate
                                              .toString()
                                              .substring(0, 10),
                                        color: ThemeClass.borderColor,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      (con.dueInstallmentResponse?.dueInstallments![index].instalmentAmount != con.dueInstallmentResponse!.dueInstallments![index].partialAmount) ?
                                      Container(
                                        decoration: BoxDecoration(
                                          color: ThemeClass.progressIndicator,
                                          borderRadius: BorderRadius.circular(12.5.sp)
                                        ),
                                        padding: EdgeInsets.symmetric(vertical:4.h ,horizontal: 10.h),
                                        child: Row(
                                          children: [
                                              AppTextRegular(title: "done_paid".tr,color: ThemeClass.whiteColor,),
                                              AppTextRegular(title: "${con.dueInstallmentResponse?.dueInstallments![index].partialAmount} ",color: ThemeClass.whiteColor,),
                                              AppTextRegular(title: "egp".tr,color: ThemeClass.whiteColor,),
                                          ],
                                        ),
                                      ) : Container(),
                                      SizedBox(height: 8.h,),
                                      (con.dueInstallmentResponse?.dueInstallments![index].instalmentAmount == con.dueInstallmentResponse!.dueInstallments![index].partialAmount) ? Container() :
                                      Container(
                                        decoration: BoxDecoration(
                                            color: ThemeClass.primaryColor,
                                            borderRadius: BorderRadius.circular(12.5.sp)
                                        ),
                                        padding: EdgeInsets.symmetric(vertical:4.h ,horizontal: 10.h),
                                        child: Row(
                                          children: [
                                            AppTextRegular(title: "wanted".tr,color: ThemeClass.whiteColor,),
                                            AppTextRegular(title: "${con.dueInstallmentResponse?.dueInstallments![index].partialAmount} ",color: ThemeClass.whiteColor,),
                                            AppTextRegular(title: "egp".tr,color: ThemeClass.whiteColor,),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 8.h,
                            );
                          },
                          itemCount: con
                              .dueInstallmentResponse!.dueInstallments!.length,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
