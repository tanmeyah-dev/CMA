// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api


import 'package:Tanmeyah/Modules/Billers/fawry.dart';
import 'package:Tanmeyah/Modules/Billers/get_bill_inquiry/get_bill_inquiry_controller.dart';
import 'package:Tanmeyah/Utilities/general_toast.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../../Models/biller_services_response.dart';
import '../../../Models/mobile_biller_response.dart';
import '../../../Theme/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Utilities/Validator.dart';
import '../../../Widgets/custom_textfield_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Widgets/receipt_alert.dart';


class GetBillInquiryScreen extends StatefulWidget {
  static const String routeName = "/getBillInquiryScreen";


  Billers billers;
  Services services;
  String paymentType;
  GetBillInquiryScreen({Key? key,required this.billers,required this.services,required this.paymentType}) : super(key: key);

  @override
  _GetBillInquiryScreenState createState() => _GetBillInquiryScreenState();
}

class _GetBillInquiryScreenState extends StateMVC<GetBillInquiryScreen> {
  _GetBillInquiryScreenState() : super(GetBillInquiryController()) {
    con = GetBillInquiryController();
  }

  late GetBillInquiryController con;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_get_bill_inquiry_screen',
        parameters: <String,dynamic>{
          "title" :"open_get_bill_inquiry_screen"
        }
    );
    con.billers = widget.billers;
    con.services = widget.services;
    con.paymentType = widget.paymentType;
    super.initState();
  }
  //
  // Future<void> askPermissions() async {
  //   PermissionStatus permissionStatus = await getContactPermission();
  //   if (permissionStatus == PermissionStatus.granted) {
  //   //   if (routeName != null) {
  //   //     Navigator.of(context).pushNamed(routeName);
  //   //   }
  //   // } else {
  //     handleInvalidPermissions(permissionStatus);
  //   }
  // }

  // Future<PermissionStatus> getContactPermission() async {
  //   PermissionStatus permission = await Permission.contacts.status;
  //   if (permission != PermissionStatus.granted &&
  //       permission != PermissionStatus.permanentlyDenied) {
  //     PermissionStatus permissionStatus = await Permission.contacts.request();
  //     return permissionStatus;
  //   } else {
  //     return permission;
  //   }
  // }


  // void handleInvalidPermissions(PermissionStatus permissionStatus) {
  //   if (permissionStatus == PermissionStatus.denied) {
  //     final snackBar = SnackBar(content: Text('Access to contact data denied'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
  //     final snackBar =
  //     SnackBar(content: Text('Contact data not available on device'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: widget.billers.billerName??"",
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: LoadingScreen(
          loading: con.loading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            width: double.infinity,
            height: double.infinity,
            child:   Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  widget.billers.logoUrl != null ?
                  CachedNetworkImage(imageUrl: widget.billers.logoUrl??"",width: 80.w,height: 50.h,) :  Image( image: const AssetImage(AppAssets.IMG_LOGO), width: 130.w, height: 80.h,),
                  AppTextBold(title: widget.billers.billerName??"",color: ThemeClass.blackColor,fontWeight: FontWeight.w500,),
                  Container(
                    width: 328.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 16.h, horizontal: 10.w),
                    child:  Container(
                      width: 280.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
                      decoration: BoxDecoration(
                          color: ThemeClass.lightBlueColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.sp)
                      ),
                      alignment: Alignment.centerRight,
                      child: AppTextBold(title: widget.billers.billerName??"",color: ThemeClass.secondaryColor,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppTextRegular(title: "previous_number".tr),
                  ),
                  SizedBox(height: 8.h,),
                  SizedBox(
                    height: 100.h,
                    child:  ListView.separated(
                      scrollDirection: Axis.horizontal, itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 83.w,
                        height: 83.h,
                        decoration: BoxDecoration(
                          color: ThemeClass.greyBackgroundColor.withOpacity(0.4),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children : [
                              Image.asset(AppAssets.IMG_CONTACT,width: 40.w,height: 40.h,),
                              SizedBox(height: 6.h,),
                              AppTextRegular(title: "01033103360",fontSize: 10.sp,)
                            ]
                        ),
                      );
                    },
                      separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10.w,); },
                      itemCount: 4,

                    ),
                  ),
                  SizedBox(height: 32.h,),
                  Align(alignment: Alignment.centerRight,child:
                  AppTextRegular(title: "phone_number".tr,color: ThemeClass.secondaryColor,fontSize: 16.sp,fontWeight: FontWeight.w400,),),
                  SizedBox(height: 12.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key : con.formKey,
                        child: CustomTextFieldWidget(
                          width: 240.w,
                          hint: "phone_number".tr,
                          controller: con.phoneController,
                          validator: (value) => Validator.validatePhone(context, value!),
                          textInputType: TextInputType.phone,
                          onchange: (_){
                            if(con.phoneController.text.length != 11) {
                              setState(() {
                                con.active = false;
                              });
                            } else {
                              setState(() {
                                con.active = true;
                              });
                            }
                          },
                          formatter: [
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        width: 60.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: ThemeClass.secondaryColor,
                            borderRadius: BorderRadius.circular(12.sp)
                        ),
                        child: Icon(Iconsax.user_square,size: 32,color: ThemeClass.whiteColor,),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                      backgroundColor: con.active ? ThemeClass.primaryColor : ThemeClass.hintColor,
                      title: "follow".tr,
                      onTap: (){
                        con.active ?
                        con.getBillInquiry().then((value) {
                          ReceiptAlert.getReceipt(context: context, onTap: (){
                           con.startPayment();
                          },
                              phoneNumber: con.billInquiryResponse?.billInqRs!.billRec![0].billingAcct.toString()??"",
                              amount: con.billInquiryResponse?.billInqRs!.billRec![0].billInfo?.billSummAmt![0].curAmt?.amt ??00.00,
                              fees: con.billInquiryResponse?.billInqRs!.billRec?[0].billInfo!.billSummAmt?[1].curAmt?.amt??0.00);
                        }) : ToastHelper.showError(context,message: "برجاء ادخال رقم الهاتف");
                          con.amount = (con.billInquiryResponse?.billInqRs!.billRec![0].billInfo?.billSummAmt![0].curAmt!.amt??0.0) + (con.billInquiryResponse?.billInqRs!.billRec?[0].billInfo!.billSummAmt?[1].curAmt!.amt??0.0);
                        },),
                  SizedBox(height: 30.h,)
                ],
              ),
          ),
        ),
      ),
    );
  }
}
