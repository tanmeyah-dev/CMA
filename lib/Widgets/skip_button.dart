// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/themeclass.dart';

class SkipButton extends StatelessWidget {
  Function() onTap;
   SkipButton({required this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        "skip".tr,
        style: TextStyle(
            fontSize: 16.sp,
            color: ThemeClass.fontColor,
        ),
      ),
    );
  }
}
