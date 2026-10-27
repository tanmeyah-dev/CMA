import 'dart:convert';

import 'package:Tanmeyah/Shared/shard_obj.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Models/user_model.dart';

class SharedPref {
  // v10 migrates legacy EncryptedSharedPreferences on first read.
  static const FlutterSecureStorage _secure = FlutterSecureStorage();

  static const String _guestToken = "guestToken";
  static const String _userObj = "userObj";
  static String? _guestTokenCache;
  static UserModel? _userCache;
  static const String _language = "language_code";
  static const String _intro = "intro";
  static const String _alreadyExist = "_alreadyExist";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String canRequestLoan = "canRequestLoan";

  /// Loads tokens into memory and moves any copy still in SharedPreferences
  /// into secure storage. Call this after [SharedObj.init].
  static Future<void> loadSession() async {
    try {
      _guestTokenCache = await _secure.read(key: _guestToken);
      final storedUser = await _secure.read(key: _userObj);
      if (storedUser != null && storedUser.isNotEmpty) {
        try {
          _userCache = UserModel.fromJson(jsonDecode(storedUser));
        } catch (_) {
          await _secure.delete(key: _userObj);
        }
      }
      await _migratePlaintextSession();
    } catch (e) {
      debugPrint('Session storage could not be read');
    }
  }

  static Future<void> _migratePlaintextSession() async {
    final prefs = SharedObj().prefs;
    if (prefs == null) return;

    final plainGuest = prefs.getString(_guestToken);
    if (_guestTokenCache == null && plainGuest != null) {
      try {
        final decoded = jsonDecode(plainGuest);
        _guestTokenCache = decoded is String ? decoded : plainGuest;
      } catch (_) {
        _guestTokenCache = plainGuest;
      }
      if (_guestTokenCache != null) {
        await _secure.write(key: _guestToken, value: _guestTokenCache);
      }
    }

    final plainUser = prefs.getString(_userObj);
    if (_userCache == null && plainUser != null) {
      try {
        _userCache = UserModel.fromJson(jsonDecode(plainUser));
        await _secure.write(key: _userObj, value: plainUser);
      } catch (_) {
        _userCache = null;
      }
    }

    await prefs.remove(_guestToken);
    await prefs.remove(_userObj);
  }

  static Future<bool?> saveToken({required String sessionToken}) async {
    _guestTokenCache = sessionToken;
    await _secure.write(key: _guestToken, value: sessionToken);
    return true;
  }

  static String? getGuestToken() {
    return _guestTokenCache;
  }

  static Future<bool?> saveUserObj({required UserModel userModel}) async {
    _userCache = userModel;
    await _secure.write(key: _userObj, value: jsonEncode(userModel.toJson()));
    return true;
  }

  static UserModel? getUserObg() {
    return _userCache;
  }

  static bool isUserLogIn() {
    return _userCache != null;
  }

  static Future<void> logOut() async {
    _userCache = null;
    await _secure.delete(key: _userObj);
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
