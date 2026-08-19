import 'package:Tanmeyah/Modules/Home/main_home/home_controller.dart';
import 'package:Tanmeyah/Modules/Main/main_screen.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Theme/themeclass.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tan_sdk/tan_sdk_entry.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitingLoanWidget extends StatelessWidget {
  HomeController con;
  WaitingLoanWidget({required this.con, super.key});

  bool get _isVlense300 => con.homeResponse?.isVlenseWaiting == true;

  bool get _isVlense200 => con.homeResponse?.isVlenseCompleteData == true;

  bool get _showBranch => !_isVlense300;

  String get _containerMessage {
    if (_isVlense200 || _isVlense300) {
      return con.homeResponse?.vlenseMessage ?? '';
    }
    return con.homeResponse?.message ?? '';
  }

  bool get _centerMessageInColumn {
    return _containerMessage.trim() == 'الطلب في سير العمل';
  }

  void _openVlenseSdk(BuildContext context) {
    final phoneNumber = SharedPref.getUserObg()?.mobileNumber;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TanSdkEntry(
          phoneNumber: phoneNumber,
          vlenseStatus: con.homeResponse?.vlenseStatusCode,
          onCompleted: () {
            Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              MainScreen.routeName,
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSlot(BuildContext context) {
    if (_isVlense200) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: CustomButton(
          width: 180,
          height: 48,
          fontSize: 18.sp,
          backgroundColor: ThemeClass.whiteColor,
          textColor: ThemeClass.primaryColor,
          title: "اكمل البيانات",
          fontWeight: FontWeight.bold,
          onTap: () => _openVlenseSdk(context),
        ),
      );
    }
    if (!_showBranch) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        openMap(
          con.homeResponse?.branchModel?.latitude ?? 0.0,
          con.homeResponse?.branchModel?.longitude ?? 0.0,
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 8.h,
          left: 24.w,
          right: 12.w,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff1d1d1d29),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextRegular(
                  title: con.homeResponse?.branchModel?.governorateName ?? "",
                  color: ThemeClass.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
                AppTextRegular(
                  title: con.homeResponse?.branchModel?.nameAr ?? "",
                  color: ThemeClass.whiteColor,
                ),
              ],
            ),
            Icon(
              Iconsax.arrow_square5,
              color: ThemeClass.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: SharedPref.getUserObg() != null
                  ? AppTextBold(
                      title: SharedPref.getUserObg()!.fullName,
                      color: ThemeClass.secondaryColor,
                      textAlign: TextAlign.start,
                    )
                  : AppTextBold(
                      title: "عميل تنميه المميز",
                      color: ThemeClass.secondaryColor,
                      textAlign: TextAlign.start,
                    ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: 400.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF384471),
                    Color(0xFFEF3C3B),
                  ],
                  stops: [0.009, 0.3],
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                ),
                borderRadius: BorderRadius.circular(24.w),
              ),
              constraints: BoxConstraints(minHeight: 168.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              alignment: Alignment.center,
              child: _centerMessageInColumn
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      child: Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 8.w),
                            child: Image.asset(
                              AppAssets.IMG_CLOCK,
                              width: 96.w,
                              height: 96.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: AppTextRegular(
                                title: _containerMessage,
                                color: ThemeClass.whiteColor,
                                textAlign: TextAlign.right,
                                fontWeight: FontWeight.w700,
                                fontSize: 26.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                          con.homeResponse?.vlenseMessage != null
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 140.w, right: 8.w),
                          child: SizedBox(
                            width: double.infinity,
                            child: AppTextRegular(
                              title: _containerMessage,
                              color: ThemeClass.whiteColor,
                              textAlign:
                                  con.homeResponse?.vlenseMessage != null
                                      ? TextAlign.start
                                      : TextAlign.center,
                              fontWeight: FontWeight.w700,
                              fontSize: 26.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 72.h,
                          width: double.infinity,
                          child: _buildBottomSlot(context),
                        ),
                      ],
                    ),
            ),
          ],
        ),
        if (!_centerMessageInColumn)
          Positioned(
            left: 2.w,
            bottom: 90.h,
            child: Image.asset(
              AppAssets.IMG_CLOCK,
              width: 150.w,
              height: 150.h,
              fit: BoxFit.fill,
            ),
          ),
      ],
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
