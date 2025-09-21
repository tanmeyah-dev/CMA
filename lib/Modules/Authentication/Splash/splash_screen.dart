// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, unrelated_type_equality_checks
import 'dart:async';
import 'package:Tanmeyah/Modules/Authentication/AppVersion/app_version_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Splash/splash_controller.dart';
import 'package:Tanmeyah/Modules/Main/main_screen.dart';
import 'package:Tanmeyah/Network/user_api.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Shared/shard_obj.dart';
import '../../../Theme/themeclass.dart';
import '../Login/login_screen.dart';
import '../OnBoarding/onboarding_screen.dart';
import '../ValidateUser/validate_user_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_analytics/firebase_analytics.dart';



class SplashScreen extends StatefulWidget {
  static String routeName = "/splashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {


  _SplashScreenState() : super(SplashController()) {
    con = SplashController();
  }

  late SplashController con;
  bool _hasNavigated = false; // Prevent multiple navigation calls

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkConnectivity();
    super.initState();
  }

  checkConnectivity() async {
    try {
      // Initialize SharedPreferences lazily when first accessed
      await SharedObj().init();
      
      // Safely access SharedPreferences with error handling
      try {
        print("<<<<<<>>>>>>>>>>>>>>>${SharedPref.getUserLatitude()}");
        print("<<<<<<>>>>>>>>>>>>>>>${SharedPref.getUserLongitude()}");
      } catch (e) {
        print('SharedPreferences access error: $e');
      }
      
      // Check connectivity with error handling and fallback
      ConnectivityResult? result;
      try {
        result = await Connectivity().checkConnectivity();
        print('Connectivity result: $result');
      } catch (e) {
        print('Connectivity check failed: $e');
        // Fallback: assume internet is available if connectivity check fails
        result = ConnectivityResult.wifi; // Default to wifi to continue app flow
      }
      
      if (result != ConnectivityResult.none) {
        // Try to get token with error handling
        try {
          await UserApi.getToken();
        } catch (e) {
          print('Failed to get token: $e');
          // Continue anyway - app can work without token initially
        }
        
        try {
          final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
          analytics.logEvent(
           name: 'open_splash',
           parameters: <String,dynamic>{
             "title" : "Open_Splash_Screen"
           }
          );
        } catch (e) {
          print('Firebase Analytics error: $e');
        }
        init();
      } else {
        Modular.to.pushNamedAndRemoveUntil(
          "/noInternetScreen", (Route<dynamic> route) => false,);
      }
    } catch (e) {
      print('Critical error in checkConnectivity: $e');
      // Fallback: just proceed with app initialization
      init();
    }
  }

  Future init() async {
    // Safely call SharedPreferences methods with error handling
    try {
      await SharedPref.logOut();
      await SharedPref.clearLocation();
      // Note: Not clearing alreadyExist flag here to preserve user login state
    } catch (e) {
      print('SharedPreferences init error: $e');
    }

    // Add a guaranteed navigation fallback after 8 seconds
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted && !_hasNavigated) {
        print('Guaranteed navigation fallback triggered');
        _navigateToNextScreen(context);
      }
    });

    Future.delayed(Duration.zero,() {
      // Try to get current position with error handling
      try {
        con.getCurrentPosition(context);
      } catch (e) {
        print('Error getting current position: $e');
        // Continue without location
      }
      
      // Add timeout to ensure navigation always happens
      Future.any([
        con.getAppVersion().then((value) async {
          if (!_hasNavigated) {
            if(value == false) {
              _hasNavigated = true;
              print('Navigating to app version screen');
              Navigator.pushNamed(context, AppVersionScreen.routeName);
            }
            else {
              await Future.delayed(const Duration(milliseconds: 1400));
              _navigateToNextScreen(context);
            }
          }
        }),
        Future.delayed(const Duration(seconds: 5), () {
          if (!_hasNavigated) {
            print('App version check timeout - proceeding with navigation');
            _navigateToNextScreen(context);
          }
        })
      ]);
    });
  }

  // Helper method for navigation with fallback
  void _navigateToNextScreen(BuildContext context) {
    // Prevent multiple navigation calls
    if (_hasNavigated || !mounted) {
      print('Navigation already completed or widget not mounted');
      return;
    }
    
    _hasNavigated = true;
    print('Navigating to next screen...');
    
    try {
      if (!SharedPref.isWatchIntro()) {
        print('Navigating to onboarding screen');
        Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
      } else if (SharedPref.isUserLogIn()) {
        print('Navigating to main screen');
        Modular.to.pushNamed(MainScreen.routeName);
      } else if(SharedPref.alreadyExist()) {
        print('Navigating to login screen');
        Modular.to.pushNamed(LoginScreen.routeName,arguments: "");
      } else {
        print('Navigating to validate user screen');
        Modular.to.pushNamed(ValidateUserScreen.routeName);
      }
    } catch (e) {
      print('Navigation error: $e');
      // Final fallback - always navigate to onboarding
      try {
        print('Fallback: Navigating to onboarding screen');
        Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
      } catch (e2) {
        print('Final navigation fallback failed: $e2');
        // Last resort - navigate to main screen directly
        try {
          print('Last resort: Navigating to main screen');
          Modular.to.pushNamed(MainScreen.routeName);
        } catch (e3) {
          print('All navigation attempts failed: $e3');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
                  backgroundColor: ThemeClass.blackColor,
                  key: _scaffoldKey,
                  body: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      AppAssets.IMG_SPLASH,
                      fit: BoxFit.fitWidth,
                    ),
                 ),
                // );
        // }
        );
  }
}
