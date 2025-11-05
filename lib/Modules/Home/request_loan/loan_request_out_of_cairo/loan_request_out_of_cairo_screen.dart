// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Models/branches_model.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import 'loan_request_out_of_cairo_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class LoanRequestOutOfCairoScreen extends StatefulWidget {
  static const String routeName = "/loanRequestOutOfCairoScreen";
  List<BranchModel> branches;
  LoanRequestOutOfCairoScreen({Key? key,required this.branches}) : super(key: key);

  @override
  _LoanRequestOutOfCairoScreenState createState() => _LoanRequestOutOfCairoScreenState();
}

class _LoanRequestOutOfCairoScreenState extends StateMVC<LoanRequestOutOfCairoScreen> {
  _LoanRequestOutOfCairoScreenState() : super(LoanRequestOutOfCairoController()) {
    con = LoanRequestOutOfCairoController();
  }

  late LoanRequestOutOfCairoController con;


  @override
  void initState() {
    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.logEvent(
    //     name: 'open_loan_request_out_of_cairo',
    //     parameters: <String,dynamic>{
    //       "title" :"open_loan_request_out_of_cairo"
    //     }
    // );


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: LoadingScreen(
        loading: con.loading,
        child: Scaffold(
          backgroundColor: ThemeClass.whiteColor,
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                color: ThemeClass.whiteColor,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Expanded(child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        AppTextMedium(title: "حسنا ...",fontSize: 22.sp,fontWeight: FontWeight.w600,color: ThemeClass.secondaryColor,),
                        SizedBox(height: 16.h,),
                        AppTextRegular(title: "  برجاء التوجه لأحد الفروع الآتية",fontSize: 18.sp,color: ThemeClass.primaryColor,fontWeight: FontWeight.w500,),
                        SizedBox(height: 30.h,),
                        SizedBox(height: 20.h,),
                        SizedBox(
                          height: 360.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (_,index){
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap : () {
                                    openMap(widget.branches[index].latitude!,widget.branches[index].longitude!);
                                  },
                                  child: Container(
                                    width : 328.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.w),
                                      color: ThemeClass.termsBackground,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal:16.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppTextMedium(title: "${widget.branches[index].nameAr}"),
                                        AppTextRegular(title: "${widget.branches[index].address}",textAlign: TextAlign.start,),
                                        AppTextRegular(title: "${widget.branches[index].distanceText}")
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                              ],
                            );
                          },
                          itemCount: widget.branches.length,
                          ),
                        ),
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

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
