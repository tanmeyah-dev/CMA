// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyPhone = "phone";
  static const _keyPassword = "password";

  static Future setPhone({required String phone}) async {
    await _storage.write(key: _keyPhone, value: phone);
  }

  static Future setPassword({required String password}) async {
    await _storage.write(key: _keyPassword, value: password);
  }

  static Future<String?> getPhoneNumber() async {
    var phoneNumber = await _storage.read(key: _keyPhone);
    return phoneNumber;
  }


  static Future<String?> getPassword() async {
    var password = await _storage.read(key: _keyPassword);
    return password;
  }

  static Future deleteData() async {
    await _storage.deleteAll();
  }
}
