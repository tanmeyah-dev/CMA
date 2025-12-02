// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';

class FireBaseOperations {
  // FirebaseMessaging is disabled in pubspec.yaml, so this class is a no-op
  static dynamic get messaging => null;
  static bool isInit = false;
  static dynamic messageListenSubscription;

  static Future init() async {
    // FirebaseMessaging is disabled, so skip initialization
    debugPrint('FirebaseMessaging is disabled, skipping init');
    return;
  }
}
