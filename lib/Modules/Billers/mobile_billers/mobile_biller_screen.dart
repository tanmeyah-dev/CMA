// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:Tanmeyah/Models/mobile_biller_response.dart';
import 'package:Tanmeyah/Modules/Billers/billers_services/billers_services_screen.dart';
import 'package:Tanmeyah/Modules/Billers/mobile_billers/mobile_biller_controller.dart';
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
import 'package:cached_network_image/cached_network_image.dart';

class MobileBillersScreen extends StatefulWidget {
  static const String routeName = "/mobileBillersScreen";

   String title;
   int billerId;
   MobileBillersScreen({ required this.billerId,required this.title, Key? key}) : super(key: key);

  @override
  _MobileBillersScreenState createState() => _MobileBillersScreenState();
}

class _MobileBillersScreenState extends StateMVC<MobileBillersScreen> {
  _MobileBillersScreenState() : super(MobileBillersController()) {
    con = MobileBillersController();
  }

  late MobileBillersController con;

  @override
  void initState() {
    con.billerId = widget.billerId;
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_mobile_billers_screen',
        parameters: <String,dynamic>{
          "title" :"open_mobile_billers_screen"
        }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: widget.title,
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
                SizedBox(
                  height: 10.h,
                ),
                (con.mobileBillersResponse != null && con.mobileBillersResponse!.billers!.isNotEmpty) ?
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, BillersServicesScreen.routeName,arguments: con.mobileBillersResponse!.billers![index],);
                          },
                          child: Container(
                              width: 300.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                color: ThemeClass.greyBackgroundColor.withOpacity(0.4)
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 24.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                con.mobileBillersResponse!.billers?[index].logoUrl??"",
                                            ),fit: BoxFit.fill
                                        )
                                    ),
                                  ),
                                  SizedBox(width: 16.w,),
                                  AppTextRegular(
                                    title: con.mobileBillersResponse!.billers![index].billerName??"",
                                    fontSize: 20.sp,
                                    color: ThemeClass.secondaryColor,
                                  ),
                                ],
                              )
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                      itemCount: con.mobileBillersResponse!.billers!.length),
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
