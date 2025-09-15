// ignore_for_file: depend_on_referenced_packages
import 'package:Tanmeyah/Modules/More/branches/branches_screen.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:Tanmeyah/Widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';

class RegistrationError extends StatelessWidget {
  static const routeName = "/registrationErrorScreen";

  final String phoneNumber;
  const RegistrationError({required this.phoneNumber, super.key});

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>>>>>phoneNumber: $phoneNumber");
    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: ThemeClass.whiteColor,
            ),
            padding: EdgeInsets.symmetric(horizontal : 20.w),
            child: Column(
              children: [
                Image.asset(AppAssets.IMG_WRONG_NUM,width: 300.w,height: 300.h,fit: BoxFit.fill,),
                SizedBox(height: 16.h,),
                AppTextBold(title: "عذرا ...",fontSize:24.sp ,color: ThemeClass.secondaryColor,),
                SizedBox(height: 20.h,),
                AppTextRegular(title: "رقم الهاتف المحمول \n غير صحيح",fontWeight: FontWeight.w500,fontSize: 20.sp,color: ThemeClass.primaryColor,),
                SizedBox(height: 16.h,),
                AppTextRegular(title: " برجاء اعادة التسجيل برقم المحمول الخاص بكم المسجل لدينا في تنميه المنتهي بـ ${phoneNumber.substring(phoneNumber.length - 2)} او زيارة احد فروعنا لتحديث رقم المحمول",fontSize: 14.sp,fontWeight: FontWeight.w300,color: ThemeClass.fontColor,),
                SizedBox(height: 24.h,),
                CustomButton(title: "اعادة التسجيل",
                    width: 216.w,
                    onTap: (){
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/validateUser', (Route<dynamic> route) => false);                    },
                ),
                SizedBox(height: 16.h,),
                CustomButton(title: "branches".tr,
                  backgroundColor: Colors.transparent,
                  width: 216.w,
                  onTap: (){
                  Navigator.pushNamed(context,BranchesScreen.routeName);
                  },
                  textColor: ThemeClass.primaryColor,
                ),
                SizedBox(height: 16.h,),
                SkipButton(onTap: (){
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/mainScreen', (Route<dynamic> route) => false);                      })

              ],
            ),
          ),
        ),
      ),
    );
  }
}
