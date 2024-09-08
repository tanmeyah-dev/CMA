// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors
import 'package:Tanmeyah/Modules/Account/account_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Conditions/conditions_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Login/login_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Terms/terms_screen.dart';
import 'package:Tanmeyah/Modules/More/about_us/about_us_screen.dart';
import 'package:Tanmeyah/Modules/More/branches/branches_screen.dart';
import 'package:Tanmeyah/Modules/More/contact_us/contact_us_screen.dart';
import 'package:Tanmeyah/Modules/More/main_more/more_controller.dart';
import 'package:Tanmeyah/Modules/More/main_more/widget/logout_alert.dart';
import 'package:Tanmeyah/Modules/More/main_more/widget/more_item.dart';
import 'package:Tanmeyah/Modules/More/main_services/main_services_screen.dart';
import 'package:Tanmeyah/Shared/shard_obj.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Theme/themeclass.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/animated_alert.dart';
import '../../Home/offers/main_offers/main_offers_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:iconsax/iconsax.dart'; // <------------ import iconsax

class MoreScreen extends StatefulWidget {
  static const String routeName = "/moreScreen";

  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends StateMVC<MoreScreen> {
  _MoreScreenState() : super(MoreController()) {
    con = MoreController();
  }

  late MoreController con;


  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_more_screen',
        parameters: <String,dynamic>{
          "title" :"open_more_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: BaseAppBar.main(
            title: "more_dot".tr.substring(0, 6),
            isBackButtonVisible: false,
          ),
          body: SafeArea(
              child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      color: ThemeClass.whiteColor,
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                          child: Column(children: [
                            Column(
                          children: [
                            !con.guestMood ?   GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, AccountScreen.routeName);
                                },
                                child: Container(
                                  width: 400.w,
                                  decoration: BoxDecoration(
                                      color: ThemeClass.profileBackground
                                  ),
                                  padding: EdgeInsets.all(8.w),
                                  child: Row(
                                    children: [
                                      Image.asset(AppAssets.IMG_PROFILE,width: 50.w,height: 50.h,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200.w,
                                            child: AppTextBold(title: "${SharedPref.getUserObg()?.fullName}",color: ThemeClass.profileContainer,maxLines: 1,textAlign: TextAlign.start,),
                                          ),
                                          AppTextRegular(title: "${SharedPref.getUserObg()?.mobileNumber}")
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Iconsax.arrow_square_left)
                                    ],
                                  ),
                                ),
                              ) : Container(),
                              SizedBox(height: 8.h),
                              FadeIn(
                                  delay: 1.5,
                                  from: SlideFrom.TOP,
                                  child: MoreItemWidget(
                                      image: AppAssets.IMG_MORE_OFFERS,
                                      title: "offers".tr,
                                      hint: false,
                                      onTap: () {
                                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                        _analytics.logEvent(
                                            name: 'request_offers_screen',
                                            parameters: <String,dynamic>{
                                              "title" :"request_request_screen"
                                            }
                                        );
                                        Navigator.pushNamed(
                                            context, MainOffersScreen.routeName);
                                      })),
                              SizedBox(height: 8.h),
                              FadeIn(
                                  delay: 2,
                                  from: SlideFrom.TOP,
                                  child: MoreItemWidget(
                                      image: AppAssets.IMG_MORE_CONTACT,
                                      title: "contact_us".tr,
                                      hint: false,
                                      onTap: () {
                                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                        _analytics.logEvent(
                                            name: 'request_contact_us_screen',
                                            parameters: <String,dynamic>{
                                              "title" :"request_contact_us_screen"
                                            }
                                        );
                                        Navigator.pushNamed(
                                            context, ContactUsScreen.routeName);
                                      })),
                              SizedBox(height: 8.h),
                              FadeIn(
                                  delay: 2.5,
                                  from: SlideFrom.TOP,
                                  child: MoreItemWidget(
                                      image: AppAssets.IMG_MORE_BRANCHES,
                                      title: "branches".tr,
                                      hint: false,
                                      onTap: () {
                                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                        _analytics.logEvent(
                                            name: 'request_branches_screen',
                                            parameters: <String,dynamic>{
                                              "title" :"request_branches_screen"
                                            }
                                        );
                                        Navigator.pushNamed(
                                            context, BranchesScreen.routeName);
                                      })),
                              SizedBox(height: 8.h),
                              FadeIn(
                                  delay: 2.5,
                                  from: SlideFrom.TOP,
                                  child: MoreItemWidget(
                                      image: AppAssets.IMG_MORE_TERMS,
                                      title: "terms".tr,
                                      hint: false,
                                      onTap: () {
                                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                        _analytics.logEvent(
                                            name: 'request_terms_screen',
                                            parameters: <String,dynamic>{
                                              "title" :"request_terms_screen"
                                            }
                                        );
                                        Navigator.pushNamed(
                                            context, TermsScreen.routeName);
                                      })),
                              SizedBox(height: 8.h),
                              FadeIn(
                                  delay: 2.5,
                                  from: SlideFrom.TOP,
                                  child: MoreItemWidget(
                                      image: AppAssets.IMG_MORE_PRIVACY,
                                      title: "privacy".tr,
                                      hint: false,
                                      onTap: () {
                                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                        _analytics.logEvent(
                                            name: 'request_privacy_screen',
                                            parameters: <String,dynamic>{
                                              "title" :"request_privacy_screen"
                                            }
                                        );
                                        Navigator.pushNamed(
                                            context, ConditionsScreen.routeName);
                                      })),
                              SizedBox(height: 8.h),
                              FadeIn(
                                  delay: 3,
                                  from: SlideFrom.TOP,
                                  child: MoreItemWidget(
                                      image: AppAssets.IMG_MORE_ABOUT,
                                      title: "about_us".tr,
                                      hint: false,
                                      onTap: () {
                                        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                        _analytics.logEvent(
                                            name: 'request_about_us_screen',
                                            parameters: <String,dynamic>{
                                              "title" :"request_about_us_screen"
                                            }
                                        );
                                        Navigator.pushNamed(
                                            context, AboutUsScreen.routeName);
                                      })),
                              SizedBox(height: 8.h),
                            !con.guestMood ?   SizedBox(height: 85.h) : SizedBox(height: 150.h,),
                          ],
                        ),
                            con.guestMood
                               ? FadeIn(
                                delay: 1,
                                from: SlideFrom.BOTTOM,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    children: [
                                      CustomButton(
                                        width: 216,
                                        title: "login".tr,
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, LoginScreen.routeName,
                                              arguments: "");
                                        },
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                               : FadeIn(
                                delay: 1,
                                from: SlideFrom.BOTTOM,
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: (){
                                        AnimatedAlertDialog(context,
                                            LogoutAlertWidget(message : "logout_alert".tr , onOkPressed: () {
                                              con.logout(context);
                                            }));
                                      },
                                      child:  Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                            color: ThemeClass.primaryColor,
                                            borderRadius: BorderRadius.circular(16.sp)
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 14.h,horizontal: 16.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppTextRegular(title: "logout".tr,color: ThemeClass.whiteColor,),
                                            Icon(Iconsax.logout5,color: ThemeClass.whiteColor,)
                                          ],
                                        ),
                                      ),
                                    )
                                )),
                            SizedBox(height: 15.h,),
                            AppTextHint(title: "App Version 2.0.0")
                      ])))))),
    );
  }
}
