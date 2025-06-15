// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';

class UserDataWidget extends StatelessWidget {
  String title;
  String data;
  UserDataWidget({required this.title,required this.data,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextRegular(
          title: title,
          color: ThemeClass.secondaryColor,
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeClass.termsBackground,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          padding: EdgeInsets.all(16.h),
          child: AppTextRegular(
            textAlign: TextAlign.start,
            title: data,
            color: ThemeClass.fontColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
