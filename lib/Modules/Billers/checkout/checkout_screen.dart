// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:Tanmeyah/Modules/Billers/service_billers/service_billers_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Models/Bill_Inquiry_Response.dart';
import '../../../Models/mobile_biller_response.dart';
import '../../../Theme/app_assets.dart';
import 'package:intl/intl.dart';

import '../../../Widgets/custom_button_widget.dart';
class CheckoutScreen extends StatefulWidget {
  static const String routeName = "/checkoutScreen";
  BillInquiryResponse billInquiryResponse;
  Billers billers;
  CheckoutScreen({required this.billInquiryResponse,required this.billers,super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends StateMVC<CheckoutScreen> {
  _CheckoutScreenState() : super(ServiceBillersController()) {
    con = ServiceBillersController();
  }

  late ServiceBillersController con;

  @override
  void initState() {
    // con.billerId = widget.billerId;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.now();
    String dateForm = DateFormat('dd MMMM yyyy، hh:mm a', 'ar').format(date);


        double amount = widget.billInquiryResponse.billInqRs!.billRec![0].billInfo?.billSummAmt![0].curAmt?.amt ??00.00;
        double fees = widget.billInquiryResponse.billInqRs!.billRec?[0].billInfo!.billSummAmt?[1].curAmt?.amt??0.00;


    return Scaffold(
      appBar: BaseAppBar.main(
        title: widget.billers.billerName!,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: LoadingScreen(
          loading: con.loading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: ThemeClass.whiteColor,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                SizedBox(height: 10.h),
                widget.billers.logoUrl != null ?
                CachedNetworkImage(imageUrl: widget.billers.logoUrl??"",width: 130.w,height: 50.h,) :  Image( image: const AssetImage(AppAssets.IMG_LOGO), width: 130.w, height: 110.h,),
                SizedBox(height: 80.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    children: [
                      AppTextBold(title: "receipt_summary".tr,color: ThemeClass.blackColor,),
                      SizedBox(height: 16.h,),
                      AppTextRegular(title: "review_summary".tr),
                      SizedBox(height: 16.h,),
                      Divider(),
                      SizedBox(height: 16.h,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                        decoration: BoxDecoration(
                          color: ThemeClass.borderColor,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextRegular(title: "phone_number".tr,color: ThemeClass.whiteColor,),
                            AppTextRegular(title: widget.billInquiryResponse.billInqRs!.billRec?[0].billingAcct??"",color: ThemeClass.whiteColor,)
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Column(
                        children: [
                          SizedBox(height: 12.h,),
                          info(title: "date_time".tr, data: dateForm),
                          info(title: "receipt_value".tr, data: "$amount ج م "),
                          info(title: "fees".tr, data: "$fees ج م "),
                          SizedBox(height: 20.h,),
                        ],
                      ),
                      SizedBox(height: 16.h,),
                      Divider(),
                      SizedBox(height: 16.h,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Color(0XFF676768),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextRegular(title: "total".tr,color: ThemeClass.whiteColor,fontWeight: FontWeight.w500,),
                            AppTextRegular(title: "${amount+fees} ج م ",color: ThemeClass.whiteColor,fontWeight: FontWeight.w500,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 140.h),
                CustomButton(title: 'دفــــع',
                  onTap: (){},
                  borderColor: Colors.transparent,
                  textColor: ThemeClass.whiteColor,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }



  Widget info({required String title, required String data}){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextRegular(title: title,color: ThemeClass.blackColor,),
            AppTextRegular(title: data,color: ThemeClass.blackColor,)
          ],
        ),
        SizedBox(height: 8.h,),
      ],
    );
  }


}
