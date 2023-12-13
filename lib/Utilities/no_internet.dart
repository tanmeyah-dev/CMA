// ignore_for_file: depend_on_referenced_packages

import 'package:Tanmeyah/Modules/Authentication/Splash/splash_screen.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/themeclass.dart';
import '../Widgets/custom_text.dart';

class NoInternetScreen extends StatefulWidget {
  static const String routeName = "/noInternetScreen";
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        isBackButtonVisible: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ThemeClass.whiteColor,
        child: Column(
          children: [
              SizedBox(height: 30.h,),
              Image.asset(AppAssets.IMG_No_INTERNET,width: 300.w,height: 300.h,),
              SizedBox(height: 64.h,),
              AppTextBold(title:"عذراً..!",color: ThemeClass.secondaryColor,fontSize: 24.sp,),
              SizedBox(height: 20.h,),
              AppTextRegular(title: "لا يوجد اتصال بالانترنت",color: ThemeClass.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.w600,),
              SizedBox(height: 20.h,),
              AppTextRegular(title: "برجاء التاكد من اتصال الانترنت وحاول مره اخري",color: ThemeClass.borderColor,fontSize: 18.sp,fontWeight: FontWeight.w400,),
              SizedBox(height: 60.h,),
              CustomButton(title: "اعاده الاتصال",
                width: 200.w,
                onTap: (){
              Navigator.pushNamed(context, SplashScreen.routeName);
            })

          ],
      ),
      ),
    );
  }
}
