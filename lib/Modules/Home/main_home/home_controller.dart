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
import '../../../Utilities/general_toast.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;




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
  const RetryOptions _retryOptions = RetryOptions(
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
    //
    // if(SharedPref.getUserLatitude() == null && SharedPref.getUserLongitude() == null) {
    //   isLocationAvailable = false;
    //   setState(() { });
    // } else {
    //   isLocationAvailable = true;
    //   setState(() { });
    // }

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
  //
  // Future<bool> handleLocationPermission(BuildContext context) async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     Geolocator.openLocationSettings();
  //     ToastHelper.showError(context, message: "يرجى تفعيل خاصية تحديد الموقع لتتمكن من طلب تمويل.");
  //     return false;
  //   }
  //   return true;
  // }
  //
  //
  //
  // Future<bool> getCurrentPosition(BuildContext context) async {
  //   bool result = false;
  //   final hasPermission = await handleLocationPermission(context);
  //   if (!hasPermission) {
  //     handleLocationPermission(context);
  //   }
  //   await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() {
  //       currentPosition = position;
  //       SharedPref.setUserLatitude(lat: currentPosition!.latitude.toString());
  //       SharedPref.setUserLongitude(long: currentPosition!.longitude.toString());
  //     });
  //     return result = true;
  //   }).catchError((e) {
  //     debugPrint(e.toString());
  //     return result = false;
  //   });
  //   return result;
  // }

}
