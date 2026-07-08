// ignore_for_file: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Models/offers_model.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';

class OfferWidget extends StatelessWidget {
  final OfferModel offerModel;

  const OfferWidget({super.key, required this.offerModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354.w,
      height: 162.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        image: const DecorationImage(
            image: CachedNetworkImageProvider(
              "https://images.unsplash.com/photo-1606041008023-472dfb5e530f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8&w=1000&q=80",
            ),
            fit: BoxFit.fitWidth),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 30.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          gradient: const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black12,
                Colors.black38,
              ]),
        ),
        child: Align(
          alignment: AlignmentDirectional.bottomStart,
          child: AppTextBold(
            title: "عرض سبتمبر",
            color: ThemeClass.whiteColor,
          ),
        ),
      ),
    );
  }
}
