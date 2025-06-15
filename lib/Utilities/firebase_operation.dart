// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FireBaseOperations {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static bool isInit = false;
  static StreamSubscription? messageListenSubscription;

  static Future init() async {
    // if(!isInit){
    //   MapHelper.onLocationChange(onChange: updateDriverLocation);
    // }
    if (!isInit) {
      await messageListenSubscription?.cancel();
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('>>>>> notification message <<<<<: ');
        debugPrint('Message data: ${message.data}');
        if (message.data["type"] == "NEW_ORDER" ||
            message.data["type"] == "STATUS_UPDATED") {}
        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification title: ${message.notification!.title}');
          debugPrint(
              'Message also contained a notification body: ${message.notification!.body}');
        }
      });
      messageListenSubscription =
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            debugPrint('>>>>> notification message <<<<<: ');
            debugPrint('Message data: ${message.data}');
            debugPrint('Message data: ${message.notification?.title}');
            debugPrint('Message data: ${message.notification?.body}');
            if (message.data["type"] == "TRIP") {
            } else if (message.data["type"] == "MESSAGE") {
              HapticFeedback.heavyImpact();
            } else if (message.data["type"] == "CARBREAKDOWN") {
              HapticFeedback.heavyImpact();
            }
          });
      isInit = true;
    }
  }
}
