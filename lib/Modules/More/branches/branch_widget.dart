// ignore_for_file: unrelated_type_equality_checks, must_be_immutable, depend_on_referenced_packages

import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';



class BranchWidget extends StatelessWidget {
  BranchModel branchModel;
  BranchWidget({required this.branchModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
        _analytics.logEvent(
            name: 'open_branch_direction',
            parameters: <String,dynamic>{
              "title" :"open_branch_name  ${branchModel.nameAr}"
            }
        );
        openMap(branchModel.latitude!,branchModel.longitude!);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Color(0xFFFAFAFA),
          color: ThemeClass.termsBackground,
          borderRadius: BorderRadius.circular(16.sp)
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 20.w),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextRegular(title: branchModel.nameAr??"",color: ThemeClass.primaryColor,fontWeight: FontWeight.w600,),
            SizedBox(height: 6.h,),
            AppTextRegular(title: branchModel.address??"" ,fontSize: 14.sp,textAlign: TextAlign.start,maxLines: 2,),
            SizedBox(height: 6.h,),
            branchModel.distance != "0" ? AppTextRegular(title: branchModel.distanceText!,fontSize: 14.sp,color: ThemeClass.fontColor.withOpacity(0.6),) : Container(),
          ],
        ),
      ),
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
