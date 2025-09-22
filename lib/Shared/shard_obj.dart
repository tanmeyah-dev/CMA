import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';



class SharedObj{
  // singleton
  factory SharedObj(){
    _this ??= SharedObj._();
    return _this!;
  }
  static SharedObj? _this;
  SharedObj._();

  SharedPreferences? prefs;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  Future init() async {
      prefs = await SharedPreferences.getInstance();
      navigatorKey = GlobalKey<NavigatorState>();
  }
  
  // Safe getter for SharedPreferences with fallback
  SharedPreferences? get safePrefs {
    return prefs;
  }
  
  // Fallback storage methods
  Future<bool> setString(String key, String value) async {
    return await prefs?.setString(key, value) ?? false;
  }
  
  String? getString(String key) {
    return prefs?.getString(key);
  }
  
  Future<bool> setBool(String key, bool value) async {
    return await prefs?.setBool(key, value) ?? false;
  }
  
  bool? getBool(String key) {
    return prefs?.getBool(key);
  }
  
  Future<bool> remove(String key) async {
    return await prefs?.remove(key) ?? false;
  }
}