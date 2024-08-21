import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class BillWidget extends StatelessWidget {
    String imageURL;
    String title;
    BillWidget({required this.title , required this.imageURL , Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: FadeIn(
        delay: 1.5,
        from: SlideFrom.LEFT,
        child : SizedBox(
          width: 60.w,
        child:   Column(
          children: [
            Container(
              width: 55.w,
              // height: 55.h,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(24.w)
              ),
              child: imageURL != null ? Image.network(imageURL,width: 40.w,height: 40.h,) : Image.asset(
                AppAssets.IMG_SERVICES_PLACEHOLDER,
                width: 40.w,
                height: 40.h,
              ),
            ),
            SizedBox(height: 8.h,),
            AppTextRegular(title: title ,color: ThemeClass.secondaryMediumColor,maxLines: 2,),
          ],
        ),
        )
      )
    );
  }
}
