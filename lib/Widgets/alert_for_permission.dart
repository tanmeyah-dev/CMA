import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../Theme/app_assets.dart';
import '../Utilities/helper.dart';
import 'custom_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';



class AlertForPermission{
  static Future checkPermission(
      {required BuildContext context, required Function() onDismiss}) async {
    Helper.showDialogWidget(
        onDismiss: onDismiss,
        context: context,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.7,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                        onTap: () async {
                          Modular.to.pop();
                        },
                        child: const Icon(Icons.close))
                  ],
                ),
                SizedBox(height: 16.h),
                Image.asset(
                  AppAssets.IMG_LOCATION,
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16.h),
                Text(
                  "لا يمكن الوصول الي موقعك",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                const Text(
                  'برجاء التاكد من تفعيل خاصيه السماح',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  title: 'اعطاء الاذن',
                  height: 40,
                  fontSize: 14.sp,
                  onTap: () async {
                    Geolocator.openAppSettings();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}