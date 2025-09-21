// ignore_for_file: depend_on_referenced_packages
import 'dart:io';

import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../Login/local_auth/user_secure_storage.dart';


class AppVersionScreen extends StatefulWidget {
  static const routeName = "/appVersionScreen";

  const AppVersionScreen({Key? key}) : super(key: key);

  @override
  State<AppVersionScreen> createState() => _AppVersionScreenState();
}

class _AppVersionScreenState extends State<AppVersionScreen> {

  @override
  void initState() {
    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.logEvent(
    //     name: 'open_update_version_screen',
    //     parameters: <String,dynamic>{
    //       "title" :"open_update_version_screen"
    //     }
    // );
    UserSecureStorage.deleteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: 'تحديث',
        isBackButtonVisible: false,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: ThemeClass.whiteColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Image.asset(
                AppAssets.IMG_VERSION,
                width: 300.w,
                height: 300.h,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 68.h,
              ),
              AppTextRegular(
                title: "app_version_title".tr,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: ThemeClass.primaryColor,
              ),
              SizedBox(
                height: 36.h,
              ),
              AppTextRegular(
                title:
                    "app_version_des".tr,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(
                height: 99.h,
              ),
              CustomButton(
                  title: "update".tr,
                  width: 216.w,
                  onTap: () {
                    moveToUpdate();
                  })
            ],
          ),
        ),
      ),
    );
  }

  moveToUpdate() {
    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.logEvent(
    //     name: 'submit_update_screen',
    //     parameters: <String,dynamic>{
    //       "title" :"submit_update_screen"
    //     }
    // );
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.tanmeyah.app' : '6450993566';
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
