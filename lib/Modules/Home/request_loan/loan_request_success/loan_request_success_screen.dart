// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
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
import '../../../../Utilities/firebase_helper.dart';


class LoanSuccessRequestScreen extends StatefulWidget {
  static const String routeName = "/loanSuccessRequestScreen";

  const LoanSuccessRequestScreen({Key? key}) : super(key: key);

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
    FirebaseHelper.logEvent(
        name: 'open_loan_request_inside_cairo',
        parameters: <String, Object>{
          "title": "open_loan_request_inside_cairo"
        }
    );
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
                      Image.asset(AppAssets.IMG_SUCCESS,width: 300.w,height: 300.h,fit: BoxFit.fill,),
                      SizedBox(height: 64.h,),
                      AppTextMedium(title: "congratulations".tr,fontSize: 18.sp,fontWeight: FontWeight.w600,color: ThemeClass.secondaryColor,),
                      SizedBox(height: 20.h,),
                      AppTextRegular(title: "success_loan_des".tr,fontSize: 18.sp,color: ThemeClass.primaryColor,),
                      SizedBox(height: 20.h,),
                      AppTextMedium(title: "خلال ٤٨ ساعة",fontSize: 18.sp,fontWeight: FontWeight.w600,color: ThemeClass.secondaryColor,),

                    ],
                  )),
                   Align(
                    alignment: Alignment.bottomCenter,
                     child: Column(
                       children: [
                         CustomButton(
                           width: 216,
                           backgroundColor: ThemeClass.buttonBackgroundColor,
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
}
