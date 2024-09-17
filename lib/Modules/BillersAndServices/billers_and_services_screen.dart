import 'package:Tanmeyah/Modules/Billers/all_billers/all_billers_screen.dart';
import 'package:Tanmeyah/Modules/More/main_services/main_services_screen.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Theme/themeclass.dart';
import 'package:iconsax/iconsax.dart';
import '../../Widgets/base_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class BillersAndServicesScreen extends StatefulWidget {
  static const String routeName = "/billersAndServices";

  const BillersAndServicesScreen({super.key});

  @override
  State<BillersAndServicesScreen> createState() => _BillersAndServicesScreenState();
}

class _BillersAndServicesScreenState extends State<BillersAndServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: ThemeClass.whiteColor,
          appBar: BaseAppBar.main(
              title: "my_services".tr, isBackButtonVisible: false),
          body: SafeArea(
              child:Container(
                padding:
                EdgeInsets.symmetric(horizontal: 20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ThemeClass.whiteColor
                ),
                child: Column(
                  children: [
                    FadeIn(
                      delay: 0.5,
                      from: SlideFrom.BOTTOM,
                      child :  GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, MainServicesScreen.routeName);
                        },
                        child:Container(
                          width: 382.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.sp),
                              color: ThemeClass.borderColor
                          ),
                          padding: EdgeInsets.all(20.w),
                          child: Row(
                            children: [
                              Icon(Iconsax.empty_wallet_add5,size: 48.sp,color: ThemeClass.primaryColor,),
                              SizedBox(width: 20.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextBold(title: "services".tr,color: ThemeClass.secondaryColor,),
                                  AppTextRegular(title: "services_des".tr,fontSize: 16.sp,fontWeight: FontWeight.w300,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    FadeIn(
                      delay: 1,
                      from: SlideFrom.BOTTOM,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, AllBillersScreen.routeName);
                        },
                        child:Container(
                          width: 382.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.sp),
                              color: ThemeClass.borderColor
                          ),
                          padding: EdgeInsets.all(20.w),
                          child: Row(
                            children: [
                              Icon(Iconsax.receipt_item5,size: 48.sp,color: ThemeClass.primaryColor,),
                              SizedBox(width: 20.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextBold(title: "billing_services".tr,color: ThemeClass.secondaryColor,),
                                  AppTextRegular(title: "billing_services_des".tr,fontSize: 16.sp,fontWeight: FontWeight.w300,)
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
          ),
      ),
    );
  }
}
