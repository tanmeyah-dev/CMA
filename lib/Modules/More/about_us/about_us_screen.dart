// ignore_for_file: depend_on_referenced_packages
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class AboutUsScreen extends StatefulWidget {
  static const routeName = "/aboutUsScreen";
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_about_us_screen',
        parameters: <String,Object>{
          "title" :"open_about_us_screen"
        }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(title: "about_tanmeyah".tr),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: ThemeClass.whiteColor,
        ),
        padding: EdgeInsets.symmetric(horizontal : 20.w),
        child: AppTextRegular(title: "about_tanmeyah_des".tr,textAlign: TextAlign.start,),
      ),
    );
  }
}
