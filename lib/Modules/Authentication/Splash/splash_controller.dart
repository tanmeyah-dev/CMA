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
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location service is enabled with error handling
      try {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
      } catch (e) {
        print('Location service check failed: $e');
        // Fallback: assume location service is enabled
        serviceEnabled = true;
      }
      
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      
      // Check location permission with error handling
      try {
        permission = await Geolocator.checkPermission();
      } catch (e) {
        print('Location permission check failed: $e');
        // Fallback: assume permission is granted
        permission = LocationPermission.whileInUse;
      }
      
      if (permission == LocationPermission.denied) {
        try {
          permission = await Geolocator.requestPermission();
        } catch (e) {
          print('Location permission request failed: $e');
          // Fallback: assume permission is granted
          permission = LocationPermission.whileInUse;
        }
        
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        try {
          ToastHelper.showError(context,
              message: "يرجى تفعيل خاصية تحديد الموقع لتتمكن من طلب تمويل ");
        } catch (e) {
          print('Toast error: $e');
        }
      }
      return true;
    } catch (e) {
      print('Critical error in handleLocationPermission: $e');
      // Fallback: assume location permission is granted
      return true;
    }
  }

  Future<bool> getCurrentPosition(BuildContext context) async {
    bool result = false;
    try {
      final hasPermission = await handleLocationPermission(context);
      if (!hasPermission) {
        handleLocationPermission(context);
      }
      
      // Try to get current position with error handling
      try {
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
          debugPrint('Geolocator getCurrentPosition error: $e');
          // Fallback: set default location or skip location
          setState(() {
            // Set default location or leave as null
            currentPosition = null;
          });
          return result = false;
        });
      } catch (e) {
        print('Geolocator getCurrentPosition critical error: $e');
        // Fallback: set default location or skip location
        setState(() {
          currentPosition = null;
        });
        result = false;
      }
    } catch (e) {
      print('Critical error in getCurrentPosition: $e');
      result = false;
    }
    return result;
  }

  Future<bool> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      
      // Try to send version to server with error handling
      try {
        isUpToDate = await SplashApi.sendVersion(version);
        print("App version check result: $isUpToDate");
      } catch (e) {
        print('Failed to check app version: $e');
        // Fallback: assume app is up to date if version check fails
        isUpToDate = false;
      }
      
      if (isUpToDate == true) {
        return false; // App needs update
      } else {
        return true; // App is up to date
      }
    } catch (e) {
      print('Critical error in getAppVersion: $e');
      // Fallback: assume app is up to date
      return true;
    }
  }
}
