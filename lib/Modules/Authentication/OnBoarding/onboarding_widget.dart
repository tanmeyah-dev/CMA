// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Models/on_boarding_model.dart';
import '../../../Theme/themeclass.dart';

class OnBoardingWidget extends StatefulWidget {

  final OnBoardingModel onBoardingModel;
  final  List<OnBoardingModel> introPages;

  const OnBoardingWidget({
    required this.onBoardingModel,
    super.key, required this.introPages,
  });

  @override
  State<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.onBoardingModel.image,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.onBoardingModel.title,
                  style:
                      TextStyle(fontSize: 18.sp, color: ThemeClass.primaryColor,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h,),
                Text(
                  widget.onBoardingModel.subtitle,
                  style:
                      TextStyle(fontSize: 18.sp,color: ThemeClass.boardingDesColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: currentIndex == index ? 20.w : 10.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index
            ? ThemeClass.primaryColor
            : ThemeClass.primaryLightPrimaryColor,
      ),
    );
  }
}
