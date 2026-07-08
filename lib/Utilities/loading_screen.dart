// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Theme/themeclass.dart';


class LoadingScreen extends StatelessWidget {
  final Widget child;
  final bool loading;
  const LoadingScreen({super.key, required this.child,this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        loading?Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.8),
          ),
        ):const SizedBox(),
        loading?Positioned(
          child: Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.red.shade400.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24.w),
              // shape: BoxShape.circle
            ),
            alignment: Alignment.center,
            child:  LoadingAnimationWidget.threeRotatingDots(color: ThemeClass.primaryColor, size: 40.sp),
          ),
        ):const SizedBox(),
      ],
    );
  }
}
