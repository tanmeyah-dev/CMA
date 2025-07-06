import 'dart:convert';
import 'package:Tanmeyah/Shared/shard_obj.dart';
import '../Models/user_model.dart';

class SharedPref {
  static const String _guestToken = "guestToken";
  static const String _userObj = "userObj";
  static const String _language = "language_code";
  static const String _intro = "intro";
  static const String _alreadyExist = "_alreadyExist";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String canRequestLoan = "canRequestLoan";

  static Future<bool?> saveToken({required String sessionToken}) async {
    return await SharedObj()
        .prefs
        ?.setString(_guestToken, jsonEncode(sessionToken));
  }


  static String? getGuestToken() {
    String? guestToken = SharedObj().prefs?.getString(_guestToken);
    if (guestToken == null) return null;
    return jsonDecode(guestToken);
  }


  static Future<bool?> saveUserObj({required UserModel userModel}) async {
    return await SharedObj()
        .prefs
        ?.setString(_userObj, jsonEncode(userModel.toJson()));
  }

  static UserModel? getUserObg() {
    String? userStringData = SharedObj().prefs?.getString(_userObj);
    if (userStringData == null) return null;
    return UserModel.fromJson(jsonDecode(userStringData));
  }

  static bool isUserLogIn() {
    return SharedObj().prefs?.getString(_userObj) != null;
  }

  static Future<void> logOut() async {
    await SharedObj().prefs?.remove(_userObj);
  }

  static String? getCurrentLang() {
    return SharedObj().prefs?.getString(_language);
  }

  static Future<void> setCurrentLang({required String lang}) async {
    await SharedObj().prefs?.setString(_language, lang);
  }

  static Future<void> saveWatchIntro() async {
    await SharedObj().prefs?.setBool(_intro, true);
  }

  static bool isWatchIntro() {
    return SharedObj().prefs?.getBool(_intro) ?? false;
  }

  static Future<void> saveAlreadyExist() async {
    await SharedObj().prefs?.setBool(_alreadyExist, true);
  }

  static bool alreadyExist() {
    return SharedObj().prefs?.getBool(_alreadyExist) ?? false;
  }

  static Future<void> setUserLatitude({required String lat}) async {
    await SharedObj().prefs?.setString(latitude, lat);
  }

  static Future<void> setUserLongitude({required String long}) async {
    await SharedObj().prefs?.setString(longitude, long);
  }
  static String? getUserLatitude() {
    return SharedObj().prefs?.getString(latitude);
  }

  static Future<void> clearLocation() async {
    await SharedObj().prefs?.remove(latitude);
    await SharedObj().prefs?.remove(longitude);
  }


  static String? getUserLongitude() {
    return SharedObj().prefs?.getString(longitude);
  }
  static Future<void> setCanRequestLoan({required bool value}) async {
    await SharedObj().prefs?.setBool(canRequestLoan, value);
  }

  static bool getCanRequestLoan() {
    return SharedObj().prefs?.getBool(canRequestLoan) ?? false;
  }
}
