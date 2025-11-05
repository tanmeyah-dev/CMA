// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../Network/fcm_background_handler.dart';

class FireBaseOperations {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static bool isInit = false;
  static StreamSubscription? messageListenSubscription;

  static Future init() async {
    if (!isInit) {
      await messageListenSubscription?.cancel();
      
      // Configure foreground notification options
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      
      // Handle notification when app is opened from terminated state
      messaging.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          debugPrint('App opened from notification: ${message.data}');
        }
      });
      
      // Handle notification when app is opened from background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('>>>>> notification opened app <<<<<: ');
        debugPrint('Message data: ${message.data}');
        if (message.notification != null) {
          debugPrint('Notification title: ${message.notification!.title}');
          debugPrint('Notification body: ${message.notification!.body}');
        }
      });
      
      // Handle foreground messages
      messageListenSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('>>>>> foreground notification received <<<<<');
        debugPrint('Message data: ${message.data}');
        debugPrint('Message notification title: ${message.notification?.title}');
        debugPrint('Message notification body: ${message.notification?.body}');
        
        // Show local notification
        showNotification(message);
        
        // Haptic feedback based on message type
        if (message.data["type"] == "TRIP") {
          // Handle trip notifications
        } else if (message.data["type"] == "MESSAGE") {
          HapticFeedback.heavyImpact();
        } else if (message.data["type"] == "CARBREAKDOWN") {
          HapticFeedback.heavyImpact();
        }
      });
      
      isInit = true;
      debugPrint('Firebase Messaging initialized successfully');
    }
  }
}
