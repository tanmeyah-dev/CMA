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
  
  // Fallback in-memory storage
  static Map<String, dynamic> _fallbackStorage = {};
  bool _useFallback = false;

  //FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    if (_useFallback) {
      print('Using fallback storage - SharedPreferences not available');
      return;
    }
    
    try {
      prefs = await SharedPreferences.getInstance();
      navigatorKey = GlobalKey<NavigatorState>();
      print('SharedPreferences instance created successfully');
    } catch (e) {
      print('SharedPreferences initialization error: $e');
      _useFallback = true;
      print('Switching to fallback in-memory storage');
    }
  }
  
  // Safe getter for SharedPreferences with fallback
  SharedPreferences? get safePrefs {
    if (_useFallback) return null;
    return prefs;
  }
  
  // Fallback storage methods
  Future<bool> setString(String key, String value) async {
    if (_useFallback) {
      _fallbackStorage[key] = value;
      return true;
    }
    return await prefs?.setString(key, value) ?? false;
  }
  
  String? getString(String key) {
    if (_useFallback) {
      return _fallbackStorage[key]?.toString();
    }
    return prefs?.getString(key);
  }
  
  Future<bool> setBool(String key, bool value) async {
    if (_useFallback) {
      _fallbackStorage[key] = value;
      return true;
    }
    return await prefs?.setBool(key, value) ?? false;
  }
  
  bool? getBool(String key) {
    if (_useFallback) {
      return _fallbackStorage[key] as bool?;
    }
    return prefs?.getBool(key);
  }
  
  Future<bool> remove(String key) async {
    if (_useFallback) {
      _fallbackStorage.remove(key);
      return true;
    }
    return await prefs?.remove(key) ?? false;
  }
}