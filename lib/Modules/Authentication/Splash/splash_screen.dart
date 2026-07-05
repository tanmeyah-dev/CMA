// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:async';
import 'package:Tanmeyah/Modules/Authentication/AppVersion/app_version_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Splash/splash_controller.dart';
import 'package:Tanmeyah/Modules/Main/main_screen.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Theme/themeclass.dart';
import '../OnBoarding/onboarding_screen.dart';
import '../ValidateUser/validate_user_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splashScreen";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  _SplashScreenState() : super(SplashController()) {
    con = controller as SplashController;
  }

  late SplashController con;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      await checkConnectivity();
    });
  }

  Future<void> checkConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    final hasConnection =
        results.any((result) => result != ConnectivityResult.none);

    if (!hasConnection) {
      _navigate('/noInternetScreen');
      return;
    }

    FirebaseAnalytics.instance.logEvent(
      name: 'open_splash',
      parameters: <String, Object>{'title': 'Open_Splash_Screen'},
    );
    await init();
  }

  Future<void> init() async {
    if (_hasNavigated) return;

    final isLoggedIn = SharedPref.isUserLogIn();

    await SharedPref.clearLocation();
    if (!isLoggedIn) {
      await SharedPref.logOut();
    }

    unawaited(con.getCurrentPosition(context));

    final isUpToDate = await con.getAppVersion();
    if (!mounted || _hasNavigated || !_isOnSplashRoute) return;

    if (isUpToDate == false) {
      _navigate(AppVersionScreen.routeName);
      return;
    }

    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted || _hasNavigated || !_isOnSplashRoute) return;

    if (!SharedPref.isWatchIntro()) {
      _navigate(OnBoardingScreen.routeName);
      return;
    }

    if (isLoggedIn) {
      _navigate(MainScreen.routeName);
      return;
    }

    _navigate(ValidateUserScreen.routeName);
  }

  bool get _isOnSplashRoute {
    final path = Modular.to.path;
    return path == SplashScreen.routeName || path == '/';
  }

  void _navigate(String route, {Object? arguments}) {
    if (_hasNavigated || !mounted || !_isOnSplashRoute) return;
    _hasNavigated = true;
    Modular.to.pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> _) => false,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      key: _scaffoldKey,
      body: Center(
        child: Hero(
          tag: 'gifHero',
          child: Image.asset(
            AppAssets.IMG_SPLASH,
            width: 280.w,
            height: 280.h,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
