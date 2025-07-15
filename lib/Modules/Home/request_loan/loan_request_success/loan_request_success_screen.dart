// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Models/loan_checkout_response.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import 'loan_request_success_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';




class LoanSuccessRequestScreen extends StatefulWidget {
  static const String routeName = "/loanSuccessRequestScreen";

  LoanCheckoutResponse loanCheckoutResponse;
  LoanSuccessRequestScreen({required this.loanCheckoutResponse,Key? key}) : super(key: key);

  @override
  _LoanSuccessRequestScreenState createState() => _LoanSuccessRequestScreenState();

}

class _LoanSuccessRequestScreenState extends StateMVC<LoanSuccessRequestScreen> {
  _LoanSuccessRequestScreenState() : super(LoanSuccessRequestController()) {
    con = LoanSuccessRequestController();
  }

  late LoanSuccessRequestController con;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: LoadingScreen(
        loading: con.loading,
        child: Scaffold(
          appBar: BaseAppBar.main(
            title: "ask_loan".tr,
            isBackButtonVisible: false,
          ),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                color: ThemeClass.whiteColor,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                children: [
                  Expanded(child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      Image.asset(AppAssets.IMG_SUCCESS_SUBMIT,width: 320.w,height: 320.h,fit: BoxFit.fill,),
                      SizedBox(height: 64.h,),
                      AppTextMedium(title: "congratulations".tr,fontSize: 18.sp,fontWeight: FontWeight.w600,color: ThemeClass.secondaryColor,),
                      SizedBox(height: 20.h,),
                      AppTextRegular(title: widget.loanCheckoutResponse.message??"",fontSize: 18.sp,color: ThemeClass.primaryColor,),
                      SizedBox(height: 32.h,),
                      GestureDetector(
                        onTap: (){
                          openMap(widget.loanCheckoutResponse.loanRequestBranch!.latitude??0.0,widget.loanCheckoutResponse.loanRequestBranch?.longitude??=0.0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.only(top: 8.h,left: 30.w,bottom: 8.h,right: 12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextMedium(title: widget.loanCheckoutResponse.loanRequestBranch?.governorateName??""),
                                  SizedBox(height: 4.h,),
                                  AppTextRegular(title: widget.loanCheckoutResponse.loanRequestBranch?.nameAr??""),
                                  SizedBox(height: 4.h,),
                                  widget.loanCheckoutResponse.loanRequestBranch?.distance != 0 ? AppTextHint(title: widget.loanCheckoutResponse.loanRequestBranch!.distanceText.toString()) : Container(),
                                ],
                              ),
                              Icon(Iconsax.arrow_square5,color: ThemeClass.primaryColor,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                   Align(
                    alignment: Alignment.bottomCenter,
                     child: Column(
                       children: [
                         CustomButton(
                           width: 385.w,
                           backgroundColor: ThemeClass.profileContainer,
                           borderColor: ThemeClass.profileContainer,
                           title: "oky".tr, onTap: (){
                           Navigator.of(context)
                               .pushNamedAndRemoveUntil('/mainScreen', (Route<dynamic> route) => false);
                         },
                         ),
                         SizedBox(height: 16.h,),
                       ],
                     ),
                  )
                ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
