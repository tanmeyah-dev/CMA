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


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkConnectivity();
    super.initState();
  }

  checkConnectivity() async {

    print("<<<<<<>>>>>>>>>>>>>>>" +  SharedPref.getUserLatitude().toString());
    print("<<<<<<>>>>>>>>>>>>>>>" +  SharedPref.getUserLongitude().toString());
    var result =  await Connectivity().checkConnectivity();
    print(result);
    if (result != ConnectivityResult.none) {
      await UserApi.getToken();
      final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
       _analytics.logEvent(
        name: 'open_splash',
        parameters: <String,dynamic>{
          "title" : "Open_Splash_Screen"
        }
      );
      init();
    } else {
      Modular.to.pushNamedAndRemoveUntil(
        "/noInternetScreen", (Route<dynamic> route) => false,);
    }
  }

  Future init() async {
    // SharedPref.logOut();
    SharedPref.clearLocation();
    Future.delayed(Duration.zero,() {
       con.getCurrentPosition(context);
      con.getAppVersion().then((value) async {
        if(value == false) {
          Navigator.pushNamed(context, AppVersionScreen.routeName);
        }
        else {
          await Future.delayed(const Duration(milliseconds: 1400));
          if (!SharedPref.isWatchIntro()) {
            Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
          } else if (SharedPref.isUserLogIn()) {
            Modular.to.pushNamed(MainScreen.routeName);
          } else if(SharedPref.alreadyExist()) {
            Modular.to.pushNamed(LoginScreen.routeName,arguments: "");
          } else {
            Modular.to.pushNamed(ValidateUserScreen.routeName);
          }
        }
      });
    });
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
