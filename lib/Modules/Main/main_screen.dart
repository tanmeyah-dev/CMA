// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_const_constructors
import 'package:Tanmeyah/Modules/Account/account_screen.dart';
import 'package:Tanmeyah/Modules/More/main_more/more_screen.dart';
import 'package:flutter/material.dart';
import '../../Theme/themeclass.dart';
import '../Home/main_home/home_screen.dart';
import '../loan/main_loan/main_loan_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Iconsax/Iconsax.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "/mainScreen";

  final int? index;
  const MainScreen({super.key, this.index});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MainLoanScreen(),
    AccountScreen(),
    MoreScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.index??0;
    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.logEvent(
    //     name: 'open_landing_screen',
    //     parameters: <String,dynamic>{
    //       "title" :"open_landing_screen"
    //     }
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Positioned(
            bottom: 2.h,
            left: 10.w,
            right: 10.w,
            child: Container(
              height: 64.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.w),
                  border: Border.all(color: ThemeClass.hintColor),
                  color: ThemeClass.whiteColor
              ),
              margin:
              EdgeInsets.only(top: 4.w, left: 20.w, right: 16.w, bottom: 14.h),
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: GNav(
                tabBackgroundColor: ThemeClass.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                activeColor: ThemeClass.whiteColor,
                iconSize: 25.sp,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                duration: Duration(milliseconds: 600),
                haptic: true,
                tabBorderRadius: 30.w,
                curve: Curves.easeOutExpo,
                gap: 8,
                color: ThemeClass.hintColor,
                tabs:  [
                  GButton(
                    icon: _selectedIndex == 0 ? Iconsax.home : Iconsax.home_2,
                  ),
                  GButton(
                    icon: _selectedIndex == 1 ? Iconsax.empty_wallet_add :  Iconsax.empty_wallet,
                  ),
                  GButton(
                    icon:_selectedIndex == 2 ?  Iconsax.profile_2user : Iconsax.profile_circle,
                  ),
                  GButton(
                    icon: _selectedIndex == 3 ?   Iconsax.more : Iconsax.more_square,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
