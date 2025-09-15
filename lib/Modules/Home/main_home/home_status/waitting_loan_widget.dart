import 'package:Tanmeyah/Modules/Home/main_home/home_controller.dart';
import 'package:Tanmeyah/Theme/themeclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../Shared/shared_prefirences.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';


class WaitingLoanWidget extends StatelessWidget {
  final HomeController con;
  const WaitingLoanWidget({required this.con, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 10.h,),
            GestureDetector(
              onTap: () {
                openMap(con.homeResponse?.branchModel?.latitude??0.0, con.homeResponse?.branchModel?.longitude??0.0);
              },
              child : Container(
                width: 400.w,
                decoration: BoxDecoration(
                  gradient:  const LinearGradient(
                    colors: [
                      Color(0xFF384471),
                      Color(0xFFEF3C3B),
                    ],
                    stops: [0.009, 0.3],
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                  ),
                  borderRadius:
                  BorderRadius.circular(24.w),
                  // color: ThemeClass.primaryColor,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 10.h),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 240.w,
                          child: AppTextRegular(
                            title: con.homeResponse?.message??"",
                            color: ThemeClass.whiteColor,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      padding: EdgeInsets.only(top: 8.h,left: 24.w,right: 12.w,bottom: 12.h),
                      decoration: BoxDecoration(
                        color: Color(0xff1d1d1d29),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextRegular(title: con.homeResponse?.branchModel?.governorateName??"",
                                color: ThemeClass.whiteColor,
                                fontWeight: FontWeight.w600,),
                              AppTextRegular(title: con.homeResponse?.branchModel?.nameAr??"",
                                color: ThemeClass.whiteColor,),
                            ],
                          ),
                          Icon(Iconsax.arrow_square5, color: ThemeClass.whiteColor,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 2.w,
          bottom: 90.h ,
          child:Image.asset(
          AppAssets.IMG_CLOCK,
          width: 150.w,
          height: 150.h,
          fit: BoxFit.fill,
        ),),
      ],
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

}



