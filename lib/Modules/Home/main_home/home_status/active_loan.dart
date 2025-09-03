// ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Modules/Home/main_home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../Main/main_screen.dart';
import '../../../../Widgets/simple_animations.dart';



class ActiveLoanWidget extends StatelessWidget {
  HomeController con;
   ActiveLoanWidget({Key? key,required this.con}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: 1.5,
      from: SlideFrom.TOP,
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, MainScreen.routeName,arguments: 1);
        },
        child: Column(
          children: [
            Container(
              width: 328.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.w),
                color: ThemeClass.primaryColor,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w, vertical: 16.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppTextRegular(
                                title: "المستحقات هذا الشهر",
                                color: ThemeClass.whiteColor,
                              ),
                              SizedBox(width: 6.w,),
                              Container(
                                width: 14.w,
                                height: 14.h,
                                decoration: BoxDecoration(
                                    color: ThemeClass.whiteColor,
                                    borderRadius: BorderRadius.circular(4.sp)
                                ),
                                child: Icon(Icons.arrow_back_ios_new_rounded,size: 8.sp,),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          AppTextBold(
                            title: con
                                .homeResponse
                                ?.loanRequest
                                ?.dueInstallmentAmount
                                .toString() ??
                                "",
                            color: ThemeClass.whiteColor,
                          ),
                        ],
                      ),
                      Image.asset(AppAssets.IMG_ACTIVE_LOAN,width: 48.w,height: 48.h,)
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFC34640),
                      borderRadius: BorderRadius.circular(16.sp),
                    ),
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                AppTextRegular(
                                  title: "اخر مبلغ مسدد",
                                  color: ThemeClass.whiteColor,
                                ),
                                SizedBox(width: 6.w,),
                                Container(
                                  width: 14.w,
                                  height: 14.h,
                                  decoration: BoxDecoration(
                                      color: ThemeClass.whiteColor,
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(Icons.arrow_back_ios_new_rounded,size: 8.sp,),
                                )
                              ],
                            ),
                            AppTextBold(title: con.homeResponse?.loanRequest?.lastPaidInstallmentAmount.toString()??"",color: ThemeClass.whiteColor,fontSize: 28.sp,),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFAA3B36),
                            borderRadius: BorderRadius.circular(6.sp),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Color(0xFFF8E254),
                                  blurRadius: 0.0,
                                  offset: Offset(0.0, 1.5)
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal:16.w,vertical: 8.h),
                          child: Column(
                            children: [
                              AppTextRegular(
                                title: "تاريخ السداد",
                                color: ThemeClass.whiteColor,
                              ),
                              SizedBox(width: 6.w,),
                              AppTextBold(title: con.homeResponse?.loanRequest?.lastPaidInstallmentDate??"8888",color: ThemeClass.whiteColor,fontSize: 16.sp,),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 10.w,
                  left: 20.w,
                  right: 20.w,
                  bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius:
                BorderRadius.circular(16.w),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Color(0xFF989899),
                      blurRadius: 0.0,
                      offset: Offset(0.0, 1.5)
                  )
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal : 18.w,vertical: 8.h),
              alignment: Alignment.center,

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      AppTextRegular(
                        title: "اجمالي المستحقات",
                        color: ThemeClass.secondaryColor,
                      ),
                      AppTextBold(
                        title: con
                            .homeResponse
                            ?.loanRequest
                            ?.totalDueAmount
                            .toString() ??
                            "",
                        color: ThemeClass.secondaryColor,
                        fontSize: 24.sp,
                      ),
                    ],
                  ),
                  Container(
                    height: 60.h,
                    width: 1,
                    color: ThemeClass.borderColor,
                  ),
                  Column(
                    children: [
                      AppTextRegular(
                        title: "اجمالي السداد",
                        color: ThemeClass.secondaryColor,
                      ),
                      AppTextBold(
                        title: con
                            .homeResponse
                            ?.loanRequest
                            ?.paidAmount
                            .toString() ??
                            "",
                        color: ThemeClass.secondaryColor,
                        fontSize: 24.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
