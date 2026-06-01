// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:Tanmeyah/Modules/Billers/billers_services/billers_services_screen.dart';
import 'package:Tanmeyah/Modules/Billers/service_billers/service_billers_controller.dart';
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

class ServiceBillersScreen extends StatefulWidget {
  static const String routeName = "/serviceBillersScreen";

   String title;
   int billerId;
  ServiceBillersScreen({ required this.billerId,required this.title, Key? key}) : super(key: key);

  @override
  _MobileBillersScreenState createState() => _MobileBillersScreenState();
}

class _MobileBillersScreenState extends StateMVC<ServiceBillersScreen> {
  _MobileBillersScreenState() : super(ServiceBillersController()) {
    con = ServiceBillersController();
  }

  late ServiceBillersController con;

  @override
  void initState() {
    con.billerId = widget.billerId;
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
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
                                  vertical: 8.h, horizontal: 24.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        image: con.mobileBillersResponse?.billers?[index].logoUrl != null ? DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                con.mobileBillersResponse!.billers?[index].logoUrl??"",
                                            ),fit: BoxFit.fill
                                        ) : const DecorationImage(
                                            image: AssetImage(AppAssets.IMG_SERVICES_PLACEHOLDER) ,fit: BoxFit.fill
                                        )
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  SizedBox(
                                    width: 210.w,
                                    child: AppTextRegular(
                                      title: con.mobileBillersResponse!.billers![index].billerName??"",
                                      fontSize: 20.sp,
                                      color: ThemeClass.secondaryColor,
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                    ),
                                  )
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
