import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../Theme/app_assets.dart';
import '../Utilities/helper.dart';
import 'custom_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';



class AlertLocation{
  static Future checkGpsWidget(
      {required BuildContext context, required Function() onDismiss}) async {
    Helper.showDialogWidget(
        onDismiss: onDismiss,
        context: context,
        child: SizedBox(
          height: 400.h,
          child: Column(
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
              SizedBox(height: 16.h,),
              Image.asset(
                AppAssets.IMG_LOCATION,
                width: 200.w,
                height: 200.h,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 16.h,),
              Text(
                "لا يمكن الوصول الي موقعك",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h,),

              const Text('برجاء التاكد من تفعيل خاصيه الموقع'),
              const Spacer(),
              // space10Horizontal,
              CustomButton(
                title: 'تفعيل الموقع الجغرافي',
                height: 40.h,
                fontSize: 14.sp,
                onTap: () async {
                  Location().requestService();
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          ),
        ));
  }
}