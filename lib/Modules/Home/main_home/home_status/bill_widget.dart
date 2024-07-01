import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';

class BillWidget extends StatelessWidget {
   const BillWidget( String imageURL , String title, {super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 66.w,
                    height: 66.h,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        color: ThemeClass.blackColor,
                        borderRadius: BorderRadius.circular(24.w)
                    ),
                    child: Image.asset(AppAssets.IMG_CALL,width : 40.w,height: 40.h,),
                  ),
                  SizedBox(height: 6.h,),
                  AppTextRegular(title: "GGGG" )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
