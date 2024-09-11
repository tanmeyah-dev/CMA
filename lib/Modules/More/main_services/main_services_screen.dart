// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'dart:math';
import 'package:Tanmeyah/Modules/More/services_detail/services_detail_screen.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';
import 'main_services_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class MainServicesScreen extends StatefulWidget {
  static const String routeName = "/mainServicesScreen";

  const MainServicesScreen({Key? key}) : super(key: key);

  @override
  _MainServicesScreenState createState() => _MainServicesScreenState();
}

class _MainServicesScreenState extends StateMVC<MainServicesScreen> {
  _MainServicesScreenState() : super(MainServicesController()) {
    con = MainServicesController();
  }

  late MainServicesController con;

  final rnd = Random();
  int crossAxisCount = 4;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_main_services_screen',
        parameters: <String,dynamic>{
          "title" :"open_main_services_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "services".tr,
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: !con.loading ? (con.servicesResponse?.products != null &&
                  con.servicesResponse!.products!.isNotEmpty)
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  color: ThemeClass.whiteColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      (con.servicesResponse?.products != null &&
                              con.servicesResponse!.products!.isNotEmpty)
                          ? SizedBox(
                            height: 660.h,
                            child: MasonryGridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: con.servicesResponse!.products!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                            onTap: () {
                              final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                              _analytics.logEvent(
                                  name: 'Open_Product_Detail',
                                  parameters: <String,dynamic>{
                                    "product_name" : con.servicesResponse?.products![index].nameAr
                                  }
                              );
                              Navigator.pushNamed(
                                  context, ServicesDetailScreen.routeName,
                                  arguments:
                                  con.servicesResponse!.products![index]);
                            },
                            child: FadeIn(
                              delay: 2,
                              from: SlideFrom.BOTTOM,
                              child: Container(
                                width: 354.w,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(20.w),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 20.w),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(20.w),

                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16.w),
                                        child:  con.servicesResponse!.products![index]
                                            .logo !=
                                            null
                                            ? Image.network(con
                                            .servicesResponse!
                                            .products![index]
                                            .logo ??
                                            "",
                                            width: 40.w,
                                            height: 40.h,
                                            fit: BoxFit.fill,
                                        )
                                            : Image.asset(
                                          AppAssets
                                              .IMG_SERVICES_PLACEHOLDER,
                                          width: 40.w,
                                          height: 40.h,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      AppTextRegular(
                                        title: "تمويل",
                                        color: ThemeClass.secondaryColor,
                                        fontSize: 16.sp,
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(height: 4.h,),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16.w),
                                        child:  con.servicesResponse!.products![index]
                                            .titleImg !=
                                            null
                                            ? Image.network(con
                                            .servicesResponse!
                                            .products![index]
                                            .titleImg ??
                                            "",
                                          width: 85.w,
                                          height: 20.h,
                                          fit: BoxFit.fill,
                                        )
                                            : Image.asset(
                                          AppAssets
                                              .IMG_SERVICES_PLACEHOLDER,
                                          width: 40.w,
                                          height: 40.h,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                          )
                          : Container(),
                    ],
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  color: ThemeClass.whiteColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              AppAssets.IMG_EMPTY_DATA,
                              width: 300.w,
                              height: 300.h,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 100.h,
                            ),
                            AppTextBold(
                              title: "sorry".tr,
                              fontSize: 24.sp,
                              color: ThemeClass.secondaryColor,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            AppTextRegular(
                              title: "no_services".tr,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeClass.primaryColor,
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 90.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  14.sp,
                                ),
                                color: ThemeClass.primaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 14.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: ThemeClass.whiteColor,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: AppTextMedium(
                                        title: "back".tr,
                                        color: ThemeClass.whiteColor,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ) : Container(),
        ),
      ),
    );
  }
}

