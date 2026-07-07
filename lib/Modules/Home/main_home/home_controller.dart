// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'dart:async';
import 'package:Tanmeyah/Models/home_response.dart';
import 'package:Tanmeyah/Models/user_model.dart';
import 'package:Tanmeyah/Network/home_api.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Shared/shared_prefirences.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:retry/retry.dart';




class HomeController extends ControllerMVC {
  // singleton
  factory HomeController() {
    _this ??= HomeController._();
    return _this!;
  }

  static HomeController? _this;

  HomeController._();

  bool loading = false, autoValidate = false ,isLogin = false;

  HomeResponse? homeResponse;

  Position? currentPosition;
  final RetryOptions _retryOptions = RetryOptions(
    maxAttempts: 3, // Maximum number of retry attempts
    delayFactor: Duration(seconds: 3), // Delay between retries
  );


  @override
  void initState() {
     fetchDataWithRetry();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> fetchDataWithRetry() async {
    try {
      final String result = await _retryOptions.retry(
            () async {
          return await getHome();
        },
        retryIf: (e) => e is Exception,
      );
      return result;
    } catch (e) {
      return 'Failed to fetch data';
    }
  }



  Future getHome() async {
    UserModel? userModel = SharedPref.getUserObg();
    loading = true;
    setState(() {});
    homeResponse = await HomeApi.getHomeData(nationalId: userModel?.nationalId ?? "");
    if(SharedPref.getUserObg() != null) {isLogin = true;} else
      {isLogin = false;}
    print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>${SharedPref.getCanRequestLoan()}");
    if(homeResponse?.canRequestLoan == false){
      await SharedPref.setCanRequestLoan(value: false);
    } else { await SharedPref.setCanRequestLoan(value: true);}
    print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>${SharedPref.getCanRequestLoan()}");
    loading = false;
    setState(() {});
}

  Future logout(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await SharedPref.logOut();
    setState(() {
      loading = false;
    });
    Modular.to.pushNamedAndRemoveUntil(
        "/loginScreen", (Route<dynamic> route) => false,
        arguments: "");
  }
}
