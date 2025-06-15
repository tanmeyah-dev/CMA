// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: duplicate_ignore, depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // ignore: depend_on_referenced_packages
import 'package:flutter_modular/flutter_modular.dart'; // ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../Cache/locales.dart';
import '../Theme/themeclass.dart';
import '../Widgets/show_image_widget.dart';

extension OnTapImageExtension on Image {
  Widget showOnTap() {
    return InkWell(
      onTap: () {
        Modular.to.push(MaterialPageRoute(
            builder: (_) => ShowImagesWidget(
              images: const [],
              image: image,
            )));
      },
      child: this,
    );
  }
}

extension OnTapFadeImageExtension on FadeInImage {
  Widget showOnTap() {
    return GestureDetector(
      onTap: () {
        Modular.to.push(MaterialPageRoute(
            builder: (_) => ShowImagesWidget(
              images: const [],
              image: image,
            )));
      },
      child: this,
    );
  }
}

extension Translate on String {
  String get tr => AppLocalizations.instance.translate(this) ?? "";
}

class Helper {
  static Future<File?> pickImage(
      {required BuildContext context, bool? isGallery}) async {
    isGallery ??= await Helper.getImageSource(
      context,
    );
    if (isGallery == null) return null;
    final XFile? file = await ImagePicker().pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 65);
    if (file != null) return File(file.path);
    return null;
  }

  static Future<bool?> getImageSource(BuildContext context,
      {bool isImage = true}) async {
    bool? isGallery;
    await showCupertinoModalPopup(
        context: context,
        barrierDismissible: true,
        useRootNavigator: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text(
                  isImage ? 'choose_image_source'.tr : "choose_video_source".tr,
                  style: TextStyle(
                      color: ThemeClass.primaryColor, fontSize: 20.sp)),
            ),
            actions: [
              Material(
                  color: Colors.grey.shade200,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      isGallery = true;
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        child: Text(
                          'from_gallery'.tr,
                          style:
                          TextStyle(color: Colors.black87, fontSize: 18.sp),
                        )),
                  )),
              Material(
                  color: Colors.grey.shade200,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      isGallery = false;
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        child: Text(
                          'from_camera'.tr,
                          style:
                          TextStyle(color: Colors.black87, fontSize: 18.sp),
                        )),
                  )),
            ],
          );
        });
    return isGallery;
  }

  static Future<List<File>> listPickImage(
      {required BuildContext context, bool? isGallery}) async {
    isGallery ??= await Helper.getImageSource(context);
    if (isGallery == null) return [];
    final List<XFile> file = await ImagePicker().pickMultiImage();
    return file.map((e) => File(e.path)).toList();
  }

  static final formatter = DateFormat('yyyyMMdd');
  static final hoursMinutesFormatter = DateFormat('HH:mm');

  static const String imagePlaceHolder =
      "https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png";
  static final timeAmOrPm = DateTime.now().hour < 12 ? 'am'.tr : "pm".tr;

  static Future showDialogWidget({required BuildContext context, Function()? onDismiss, required Widget child,Function()? onTap})async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeClass.whiteColor,
          content: child,
        );
      },
    ).then((_) {
      if (onDismiss != null) onDismiss();
    });
  }

}
