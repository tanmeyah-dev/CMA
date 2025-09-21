import 'dart:convert';
import 'package:Tanmeyah/Shared/shard_obj.dart';
import '../Models/user_model.dart';
import '../Network/network_methods.dart';

class SharedPref {
  static const String _guestToken = "guestToken";
  static const String _userObj = "userObj";
  static const String _language = "language_code";
  static const String _intro = "intro";
  static const String _alreadyExist = "_alreadyExist";
  static const String latitude = "latitude";
  static const String longitude = "longitude";

  static Future<bool?> saveToken({required String sessionToken}) async {
    return await SharedObj().setString(_guestToken, jsonEncode(sessionToken));
  }


  static String? getGuestToken() {
    String? guestToken = SharedObj().getString(_guestToken);
    if (guestToken == null) return null;
    return jsonDecode(guestToken);
  }


  static Future<bool?> saveUserObj({required UserModel userModel}) async {
    return await SharedObj().setString(_userObj, jsonEncode(userModel.toJson()));
  }

  static UserModel? getUserObg() {
    String? userStringData = SharedObj().getString(_userObj);
    if (userStringData == null) return null;
    return UserModel.fromJson(jsonDecode(userStringData));
  }

  static bool isUserLogIn() {
    return SharedObj().getString(_userObj) != null;
  }

  static Future<void> logOut() async {
    try {
      await SharedObj().remove(_userObj);
      // Clear auth header cache on logout
      NetworkMethods.clearAuthHeaderCache();
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  static String? getCurrentLang() {
    return SharedObj().getString(_language);
  }

  static Future<void> setCurrentLang({required String lang}) async {
    await SharedObj().setString(_language, lang);
  }

  static Future<void> saveWatchIntro() async {
    try {
      // Ensure SharedObj is initialized
      await SharedObj().init();
      bool result = await SharedObj().setBool(_intro, true);
      print('saveWatchIntro result: $result');
      // Verify the value was saved
      bool? savedValue = SharedObj().getBool(_intro);
      print('saveWatchIntro verification: $savedValue');
    } catch (e) {
      print('Error saving watch intro: $e');
    }
  }

  static bool isWatchIntro() {
    try {
      // Ensure SharedObj is initialized
      SharedObj().init();
      bool? value = SharedObj().getBool(_intro);
      bool result = value ?? false;
      print('isWatchIntro: $value -> $result');
      return result;
    } catch (e) {
      print('Error getting watch intro: $e');
      return false;
    }
  }

  static Future<void> saveAlreadyExist() async {
    try {
      // Ensure SharedObj is initialized
      await SharedObj().init();
      bool result = await SharedObj().setBool(_alreadyExist, true);
      print('saveAlreadyExist result: $result');
      // Verify the value was saved
      bool? savedValue = SharedObj().getBool(_alreadyExist);
      print('saveAlreadyExist verification: $savedValue');
    } catch (e) {
      print('Error saving already exist: $e');
    }
  }

  static bool alreadyExist() {
    try {
      // Ensure SharedObj is initialized
      SharedObj().init();
      bool? value = SharedObj().getBool(_alreadyExist);
      bool result = value ?? false;
      print('alreadyExist: $value -> $result');
      return result;
    } catch (e) {
      print('Error getting already exist: $e');
      return false;
    }
  }

  static Future<void> clearAlreadyExist() async {
    await SharedObj().remove(_alreadyExist);
  }

  static Future<void> setUserLatitude({required String lat}) async {
    await SharedObj().setString(latitude, lat);
  }

  static Future<void> setUserLongitude({required String long}) async {
    await SharedObj().setString(longitude, long);
  }
  static String? getUserLatitude() {
    try {
      return SharedObj().getString(latitude);
    } catch (e) {
      print('Error getting user latitude: $e');
      return null;
    }
  }

  static Future<void> clearLocation() async {
    try {
      await SharedObj().remove(latitude);
      await SharedObj().remove(longitude);
    } catch (e) {
      print('Error clearing location: $e');
    }
  }


  static String? getUserLongitude() {
    try {
      return SharedObj().getString(longitude);
    } catch (e) {
      print('Error getting user longitude: $e');
      return null;
    }
  }
}
