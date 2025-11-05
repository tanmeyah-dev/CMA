// ignore_for_file: must_be_immutable
import 'package:Tanmeyah/Modules/Home/main_home/home_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Shared/shared_prefirences.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../Main/main_screen.dart';
import 'package:Iconsax/Iconsax.dart';


class ActiveLoanWidget extends StatelessWidget {
  HomeController con;
   ActiveLoanWidget({Key? key,required this.con}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, MainScreen.routeName,arguments: 1);
        },
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 18.w),
                child :  AppTextBold(
                  title:
                  SharedPref.getUserObg()!.fullName,
                  color: ThemeClass.secondaryColor,textAlign: TextAlign.start,)
              ),
            ),
            SizedBox(height: 6.h,),
            Container(
              width: 320.w,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(16.sp),
                  image: const DecorationImage(
                      image: AssetImage(
                        AppAssets.IMG_LOAN_BACKGROUND,),fit: BoxFit.fill
                  )
              ),
              padding: EdgeInsets.all(16.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextRegular(
                        title: "total_loan".tr,
                        fontSize: 18.sp,
                        color: ThemeClass.whiteColor,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          AppTextBold(
                            title: con.homeResponse?.loanRequest?.totalAmount.toString()??"0",
                            color: ThemeClass.whiteColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 36.sp,
                          ),
                          SizedBox(width: 4.w,),
                          AppTextRegular(title: "ج. م",color: ThemeClass.whiteColor,fontSize: 20.sp,)
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 50.w,
                    height: 50.h,
                    child: Icon( Iconsax.arrow_square_left ,color: ThemeClass.whiteColor,),
                  ),
                ],
              ),
            ),
            Container(
              width: 320.w,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(24.sp)
              // ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  bottom: BorderSide(
                    color: ThemeClass.primaryColor,
                    width: 3.w, // Thickness of the line
                  ),
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppTextRegular(title: "month_need".tr,color: ThemeClass.primaryColor,fontSize: 16.sp,),
                          Icon(Iconsax.arrow_square_left,color: ThemeClass.primaryColor,size: 16.sp,)
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          AppTextBold(title: con.homeResponse!.loanRequest!.dueInstallmentAmount.toString()),
                          SizedBox(width: 4.w,),
                          AppTextRegular(title: "ج. م",color: ThemeClass.primaryColor,fontSize: 14.sp,)
                        ],
                      )
                    ],
                  ),
                ],
              ) ,
            ),
          ],
        )
    );
  }
}




