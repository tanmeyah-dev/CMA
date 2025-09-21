// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyPhone = "phone";
  static const _keyPassword = "password";

  static Future setPhone({required String phone}) async {
    try {
      await _storage.write(key: _keyPhone, value: phone);
    } catch (e) {
      print('Secure storage setPhone failed: $e');
      // Fallback: could store in SharedPreferences or skip
    }
  }

  static Future setPassword({required String password}) async {
    try {
      await _storage.write(key: _keyPassword, value: password);
    } catch (e) {
      print('Secure storage setPassword failed: $e');
      // Fallback: could store in SharedPreferences or skip
    }
  }

  static Future<String?> getPhoneNumber() async {
    try {
      var phoneNumber = await _storage.read(key: _keyPhone);
      return phoneNumber;
    } catch (e) {
      print('Secure storage getPhoneNumber failed: $e');
      // Fallback: return null if secure storage fails
      return null;
    }
  }

  static Future<String?> getPassword() async {
    try {
      var password = await _storage.read(key: _keyPassword);
      return password;
    } catch (e) {
      print('Secure storage getPassword failed: $e');
      // Fallback: return null if secure storage fails
      return null;
    }
  }

  static Future deleteData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      print('Secure storage deleteData failed: $e');
      // Fallback: continue anyway
    }
  }
}
