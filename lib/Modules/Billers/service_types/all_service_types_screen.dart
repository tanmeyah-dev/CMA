// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

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

import '../../../Models/home_response.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Theme/app_assets.dart';
import '../../../Widgets/animated_alert.dart';
import '../../../Widgets/service_alert_widget.dart';
import '../service_billers/service_billers_screen.dart';
import 'all_service_types_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';import 'package:awesome_dialog/awesome_dialog.dart';


class AllServiceTypesScreen extends StatefulWidget {
  static const String routeName = "/allServiceTypesScreen";


  AllServiceTypesScreen({Key? key}) : super(key: key);

  @override
  _AllBillersScreenState createState() => _AllBillersScreenState();
}

class _AllBillersScreenState extends StateMVC<AllServiceTypesScreen> {
  _AllBillersScreenState() : super(AllServicesTypeController()) {
    con = AllServicesTypeController();
  }

  late AllServicesTypeController con;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_all_billers_screen',
        parameters: <String,dynamic>{
          "title" :"open_all_billers_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "billing_services".tr,
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
                (con.getAllServicesResponse != null && con.getAllServicesResponse!.serviceTypes!.isNotEmpty) ?
                MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: con.getAllServicesResponse?.serviceTypes?.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                        _analytics.logEvent(
                            name: 'request_service',
                            parameters: <String,dynamic>{
                              "title" :"request_service_with  ${con.getAllServicesResponse?.serviceTypes![index].serviceTypeName}"
                            }
                        );
                        if( SharedPref.getUserObg() != null) {
                          Navigator.pushNamed(context, ServiceBillersScreen.routeName,
                              arguments: [con.getAllServicesResponse?.serviceTypes![index].serviceTypeName,con.getAllServicesResponse?.serviceTypes![index].id]);
                        } else {
                          AnimatedAlertDialog(
                              context, ServicesAlert(
                              onLoginTaped:
                                  () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/loginScreen', (Route<dynamic> route) => false,arguments: "");
                              }));
                        }
                      },
                      child: FadeIn(
                        delay: 2,
                        from: SlideFrom.BOTTOM,
                        child: Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(20.w),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(24.w),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(16.w),
                                  child: con.getAllServicesResponse?.serviceTypes![index]
                                      .logoUrl !=
                                      null
                                      ? Image.network(con.getAllServicesResponse?.serviceTypes![index]
                                      .logoUrl ??
                                      "",width: 48.w,height: 52.h,)
                                      : Image.asset(
                                    AppAssets
                                        .IMG_SERVICES_PLACEHOLDER,
                                    width: 48.w,height: 52.h,
                                  ),
                                ),
                                AppTextRegular(
                                  title: con.getAllServicesResponse?.serviceTypes![index]
                                      .serviceTypeName ??
                                      "",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  fontSize: 16.sp,

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ):Container(),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
