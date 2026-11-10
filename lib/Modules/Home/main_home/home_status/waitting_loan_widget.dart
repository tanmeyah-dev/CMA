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

  bool get _showBranch => !_isVlense300 && _hasBranch;

  bool get _hasBranch {
    final branch = con.homeResponse?.branchModel;
    if (branch == null) return false;
    final governorate = branch.governorateName?.trim() ?? '';
    final name = branch.nameAr?.trim() ?? '';
    return governorate.isNotEmpty || name.isNotEmpty;
  }

  String get _containerMessage {
    if (_isVlense200 || _isVlense300) {
      return con.homeResponse?.vlenseMessage?.trim() ?? '';
    }
    final waiting = con.homeResponse?.waitingMessage?.trim() ?? '';
    if (waiting.isNotEmpty) return waiting;
    return con.homeResponse?.message?.trim() ?? '';
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

  BoxDecoration _cardDecoration(List<Color> colors, {List<double>? stops}) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        stops: stops,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: colors.last.withOpacity(0.22),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    final name = SharedPref.getUserObg()?.fullName;
    return AppTextBold(
      title: (name != null && name.trim().isNotEmpty) ? name : "عميل تنميه المميز",
      color: ThemeClass.secondaryColor,
      textAlign: TextAlign.start,
    );
  }

  Widget _buildVlense200Card(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _cardDecoration(const [
        Color(0xFF8B1A1A),
        Color(0xFFF44336),
      ]),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextRegular(
                  title: _containerMessage,
                  color: ThemeClass.whiteColor,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  shrinkWrap: true,
                  radius: 12,
                  edgeInsets: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 14.w,
                  ),
                  fontSize: 18.sp,
                  backgroundColor: ThemeClass.whiteColor,
                  borderColor: ThemeClass.whiteColor,
                  textColor: ThemeClass.primaryColor,
                  title: "عقد التمويل",
                  fontWeight: FontWeight.bold,
                  onTap: () => _openVlenseSdk(context),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Image.asset(
            AppAssets.IMG_CONTRACT,
            width: 120.w,
            height: 132.w,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildVlense300Card() {
    return Container(
      width: double.infinity,
      decoration: _cardDecoration(const [
        Color(0xFF8B1A1A),
        Color(0xFFF44336),
      ]),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AppTextRegular(
              title: _containerMessage,
              color: ThemeClass.whiteColor,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Image.asset(
            AppAssets.IMG_CLOCK,
            width: 120.w,
            height: 120.w,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSlot(BuildContext context) {
    if (!_showBranch) return const SizedBox.shrink();
    final branch = con.homeResponse!.branchModel!;
    final governorate = branch.governorateName?.trim() ?? '';
    final name = branch.nameAr?.trim() ?? '';
    final distance = branch.distanceText?.trim() ?? '';

    return GestureDetector(
      onTap: () {
        openMap(
          _asDouble(branch.latitude),
          _asDouble(branch.longitude),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.16),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (governorate.isNotEmpty)
                    AppTextRegular(
                      title: governorate,
                      color: ThemeClass.whiteColor,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  if (name.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    AppTextRegular(
                      title: name,
                      color: ThemeClass.whiteColor,
                      textAlign: TextAlign.start,
                      fontSize: 14.sp,
                    ),
                  ],
                  if (distance.isNotEmpty && branch.distance != 0) ...[
                    SizedBox(height: 2.h),
                    AppTextRegular(
                      title: distance,
                      color: ThemeClass.whiteColor.withOpacity(0.85),
                      textAlign: TextAlign.start,
                      fontSize: 12.sp,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Iconsax.arrow_square5,
              color: ThemeClass.whiteColor,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGreeting(),
          SizedBox(height: 10.h),
          if (_isVlense300)
            _buildVlense300Card()
          else if (_isVlense200)
            _buildVlense200Card(context)
          else
            _buildDefaultWaitingCard(context),
        ],
      ),
    );
  }

  Widget _buildDefaultWaitingCard(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 168.h),
      decoration: _cardDecoration(
        const [
          Color(0xFF384471),
          Color(0xFFEF3C3B),
        ],
        stops: const [0.05, 0.85],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppTextRegular(
                  title: _containerMessage,
                  color: ThemeClass.whiteColor,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Image.asset(
                AppAssets.IMG_CLOCK,
                width: 108.w,
                height: 108.w,
                fit: BoxFit.contain,
              ),
            ],
          ),
          if (_showBranch) ...[
            SizedBox(height: 14.h),
            _buildBottomSlot(context),
          ],
        ],
      ),
    );
  }

  static double _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static Future<void> openMap(double latitude, double longitude) async {
    if (latitude == 0 && longitude == 0) return;
    final String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&mode=d';
    final uri = Uri.parse(googleUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
