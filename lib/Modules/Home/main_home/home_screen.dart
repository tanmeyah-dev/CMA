// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:math';
import 'package:Tanmeyah/Modules/Home/request_loan/loan_request_terms/loan_request_terms_screen.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:Tanmeyah/Widgets/login_alert_widget.dart';
import 'package:Tanmeyah/Widgets/service_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/loading_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/animated_alert.dart';
import '../../Billers/service_billers/service_billers_screen.dart';
import '../../Billers/service_types/all_service_types_screen.dart';
import '../request_loan/loan_request_out_of_cairo/loan_request_out_of_cairo_screen.dart';
import 'home_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'home_status/active_loan.dart';
import 'home_status/bill_widget.dart';
import 'home_status/offers_widget.dart';
import 'home_status/products_widget.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  int crossAxisCount = 4;


  Position? currentPosition;

  _HomeScreenState() : super(HomeController()) {
    con = HomeController();
  }

  late HomeController con;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_home_screen',
        parameters: <String,dynamic>{
          "title" :"open_home_screen"
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
          backgroundColor: ThemeClass.whiteColor,
          appBar: BaseAppBar.main(
            isBackButtonVisible: false,
            actions: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage(AppAssets.IMG_LOGO),
                      width: 100.w,
                      height: 40.h,
                    ),
                  ],
                ),
              )
            ],
          ),
          body:  GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: ThemeClass.whiteColor,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: SizedBox(
                                    width: 50.w,
                                    child: AppTextHint(title: "hello".tr)))),
                    SizedBox(height: 10.h,),
                    (con.homeResponse?.loanRequest == null)
                        ? (con.homeResponse?.canRequestLoan == true)
                                 ? Stack(
                                    children: [
                                    Container(
                                        decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(24.w),
                                        color: ThemeClass.whiteColor
                                        ),
                                       margin: EdgeInsets.only(top : 16.w,right: 16.w,left: 16.w),
                                       child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                                Padding(padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                  child :  SharedPref.getUserObg() != null
                                                   ?  AppTextBold(
                                                 title:
                                                 SharedPref.getUserObg()!.fullName,
                                                 color: ThemeClass.secondaryColor,textAlign: TextAlign.start,)
                                                   : AppTextBold(
                                                    title:
                                                    "عميل تنميه المميز",
                                                    color: ThemeClass.secondaryColor,textAlign: TextAlign.start,),
                                                ),
                                                SizedBox(height: 20.h,),
                                                Container(
                                                  width: 398.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(24.sp),
                                                    image: DecorationImage(
                                                        image: AssetImage(AppAssets.IMG_HOME_BACKGROUND),
                                                        fit: BoxFit.fill
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerRight,
                                                  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 12.h,),
                                                      SizedBox(
                                                        width : 120.w,
                                                        child: AppTextRegular(
                                                          title: """اطلب
تمويل مشروعك
بكل سهولة
                                                          """,
                                                          color: ThemeClass.whiteColor,
                                                          textAlign: TextAlign.start,
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      CustomButton(
                                                          width : 135,
                                                          fontSize: 20.sp,
                                                          backgroundColor:
                                                          ThemeClass.whiteColor,
                                                          textColor:
                                                          ThemeClass.primaryColor,
                                                          title: "ask_loan".tr,
                                                          fontWeight: FontWeight.bold,
                                                          onTap: () async {
                                                            if (con.isLogin)  {
                                                              final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                                              _analytics.logEvent(
                                                                  name: 'request_loan_button',
                                                                  parameters: <String,dynamic>{
                                                                    "title" :"request_loan_button"
                                                                  }
                                                              );
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  LoanRequestTermsScreen
                                                                      .routeName);
                                                            } else {
                                                              AnimatedAlertDialog(
                                                                  context, LoginAlert(
                                                                  onLoginTaped:
                                                                      () {
                                                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                                                        '/loginScreen', (Route<dynamic> route) => false,arguments: "");
                                                                  }));
                                                            }
                                                          }),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        ],
                                    ),
                                  ),
                                    Positioned(
                                      left: 16.w,
                                      top: 20.h,
                                      bottom: 20.h,
                                      child: Image.asset(
                                      AppAssets.IMG_HOME,
                                      width: 220.w,
                                      height: 222.h,
                                      fit: BoxFit.fill,
                                    ),)
                                ],
                              )
                                :  (con.homeResponse?.branches == null || con.homeResponse!.branches!.isEmpty) ? Container(
                        width: 328.w,
                        // height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(24.w),
                          // color: ThemeClass.primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 130.w,
                              child: AppTextRegular(
                                title: con.homeResponse?.message??"",
                                color: ThemeClass.whiteColor,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                            Image.asset(
                              AppAssets.IMG_CLOCK,
                              width: 160.w,
                              height: 160.h,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ) : Container(
                        width: 328.w,
                        // height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(24.w),
                          // color: ThemeClass.primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 16.h),
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width : 120.w,
                                  child: AppTextRegular(
                                    title: """اطلب
تمويل مشروعك
بكل سهولة
                                    """,
                                    color: ThemeClass.whiteColor,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                CustomButton(
                                    width: 130,
                                    edgeInsets:
                                    EdgeInsets.symmetric(
                                        vertical: 6.h,
                                        horizontal: 17.w),
                                    fontSize: 20.sp,
                                    backgroundColor:
                                    ThemeClass.whiteColor,
                                    textColor:
                                    ThemeClass.primaryColor,
                                    title: "ask_loan".tr,
                                    fontWeight: FontWeight.bold,
                                    onTap: () async {
                                      final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                      _analytics.logEvent(
                                          name: 'open_nearest_branches',
                                          parameters: <String,dynamic>{
                                            "title" :"open_nearest_branches"
                                          }
                                      );
                                      Navigator.pushNamed(
                                          context,
                                          LoanRequestOutOfCairoScreen
                                              .routeName,arguments: con.homeResponse!.branches);
                                    }
                                ),
                              ],
                            ),
                            Image.asset(
                              AppAssets.IMG_HOME,
                              width: 130.w,
                              height: 130.h,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ) : ActiveLoanWidget(con: con,),
                    SizedBox(
                      height: 16.h,
                    ),
                    (con.homeResponse?.serviceTypes != null &&
                        con.homeResponse!.serviceTypes?.length != 0) ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextMedium(title: "billing_services".tr,color: ThemeClass.blackColor,fontWeight: FontWeight.w400,fontSize: 24.sp,),
                              GestureDetector(
                                onTap:(){
                              final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                              _analytics.logEvent(
                              name: 'request_view_all_offers',
                              parameters: <String,dynamic>{
                              "title" :"request_view_all_offers"
                              }
                              );
                              Navigator.pushNamed(context, AllServiceTypesScreen.routeName);
                                },
                                child:   Row(
                                  children: [
                                    AppTextMedium(title: "all_services".tr,color: ThemeClass.yellowColor,fontSize: 14.sp,fontWeight: FontWeight.w400,),
                                    Icon(Iconsax.arrow_square_left5,color: ThemeClass.yellowColor,size: 16.sp,)
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          (con.homeResponse?.serviceTypes != null &&
                              con.homeResponse!.serviceTypes?.length != 0) ?
                          SizedBox(
                          height: 125.h,
                          child:  ListView.separated(itemBuilder:(_,index){
                            return GestureDetector(
                              onTap: (){
                                if( SharedPref.getUserObg() != null) {
                                  Navigator.pushNamed(context, ServiceBillersScreen.routeName,
                                      arguments: [con.homeResponse?.serviceTypes?[index].serviceTypeName,con.homeResponse?.serviceTypes?[index].id]);
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
                              child:  BillWidget(imageURL: con.homeResponse!.serviceTypes![index].logoUrl, title: con.homeResponse!.serviceTypes![index].serviceTypeName!),
                            );
                          } ,
                            itemCount: con.homeResponse!.serviceTypes!.length,
                            scrollDirection: Axis.horizontal, separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 14.w,);
                            } ,

                          ),
                        ) : Container()
                        ],
                      ),
                    ) : Container(),
                    (con.homeResponse?.offers != null &&
                        con.homeResponse!.offers.length != 0) ? OffersWidget(con: con) : Container(),
                    (con.homeResponse?.products != null &&
                        con.homeResponse!.products.isNotEmpty) ? ProductsWidget(con: con,) : Container(),
                    SizedBox(
                      height: 80.h,
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
