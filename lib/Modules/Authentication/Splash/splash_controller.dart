// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, depend_on_referenced_packages

import 'package:Tanmeyah/Network/splash_api.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Utilities/general_toast.dart';

class SplashController extends ControllerMVC {
  Position? currentPosition;

  factory SplashController() {
    _this ??= SplashController._();
    return _this!;
  }

  static SplashController? _this;

  SplashController._();

  bool? isUpToDate;

  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ToastHelper.showError(context,
          message: "يرجى تفعيل خاصية تحديد الموقع لتتمكن من طلب تمويل ");
    }
    return true;
  }

  Future<bool> getCurrentPosition(BuildContext context) async {
    bool result = false;
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) {
      handleLocationPermission(context);
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        SharedPref.setUserLatitude(lat: currentPosition!.latitude.toString());
        SharedPref.setUserLongitude(
            long: currentPosition!.longitude.toString());
      });
      return result = true;
    }).catchError((e) {
      debugPrint(e.toString());
      return result = false;
    });
    return result;
  }

  Future<bool> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = await packageInfo.version;
    isUpToDate = await SplashApi.sendVersion(version);
    print("MMMMMM$isUpToDate");
    if (isUpToDate == true) {
      return false;
    } else {
      return true;
    }
  }
}
