import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';

class BillWidget extends StatelessWidget {
    String? imageURL;
    String title;
    BillWidget({required this.title , this.imageURL , super.key});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68.w,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(24.w)
              ),
              child: imageURL != null ? Image.network(imageURL!,width: 66.w,height: 66.h,fit: BoxFit.fill,) : Image.asset(
                AppAssets.IMG_SERVICES_PLACEHOLDER,
                width: 66.w,
                height: 66.h,
                fit: BoxFit.fill,
              )
          ),
          AppTextRegular(title: title ,color: ThemeClass.secondaryMediumColor,maxLines: 2,),
        ],
      ),
    );
  }
}
