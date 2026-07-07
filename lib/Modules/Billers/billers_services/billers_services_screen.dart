// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:Tanmeyah/Models/mobile_biller_response.dart';
import 'package:Tanmeyah/Modules/Billers/billers_services/billers_services_controller.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Theme/app_assets.dart';

class BillersServicesScreen extends StatefulWidget {
  static const String routeName = "/billersServicesScreen";

  Billers billers;
  BillersServicesScreen({required this.billers, super.key});

  @override
  _BillersServicesScreenState createState() => _BillersServicesScreenState();
}

class _BillersServicesScreenState extends StateMVC<BillersServicesScreen> {
  _BillersServicesScreenState() : super(BillersServicesController()) {
    con = BillersServicesController();
  }

  late BillersServicesController con;

  @override
  void initState() {
    con.billers = widget.billers;
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'open_mobile_billers_screen',
        parameters: <String,Object>{
          "title" :"open_mobile_billers_screen"
        }
    );
    super.initState();
  }


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
            color: ThemeClass.whiteColor,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                widget.billers.logoUrl != null ?
                CachedNetworkImage(imageUrl: widget.billers.logoUrl??"",width: 130.w,height: 80.h,) :
                Image( image: const AssetImage(AppAssets.IMG_LOGO), width: 130.w, height: 80.h,),
                AppTextBold(title: widget.billers.billerName??"",color: ThemeClass.blackColor,fontWeight: FontWeight.w500,),
                SizedBox(
                  height: 50.h,
                ),
                (con.billerServicesResponse?.services != null && con.billerServicesResponse!.services!.isNotEmpty) ?
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: (){
                             // Navigator.pushNamed(context, GetBillInquiryScreen.routeName,arguments: [con.billers,con.billerServicesResponse!.services![index],con.billerServicesResponse!.services![index].pmtType]);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.h, horizontal: 16.w),
                          child: Container(
                            width: 310.w,
                            padding: EdgeInsets.only(top: 4.w,left: 12.w,right: 12.w,bottom: 14.h),
                            decoration: BoxDecoration(
                              color: ThemeClass.greyBackgroundColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(8.sp)
                            ),
                            alignment: Alignment.centerRight,
                            child: AppTextBold(title: con.billerServicesResponse!.services![index].serviceName??"",color: ThemeClass.secondaryColor,fontWeight: FontWeight.w500,textAlign: TextAlign.start,),
                          ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                      itemCount: con.billerServicesResponse!.services!.length),
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
