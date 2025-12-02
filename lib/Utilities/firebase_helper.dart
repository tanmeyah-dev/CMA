// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

/// Helper class to safely access FirebaseAnalytics
/// Returns null if Firebase is not initialized
class FirebaseHelper {
  static FirebaseAnalytics? _analytics;
  
  /// Safely get FirebaseAnalytics instance
  /// Returns null if Firebase is not initialized or fails
  static FirebaseAnalytics? getAnalytics() {
    if (_analytics != null) {
      return _analytics;
    }
    
    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        return null;
      }
      _analytics = FirebaseAnalytics.instance;
      return _analytics;
    } catch (e) {
      print('FirebaseAnalytics access error (ignored): $e');
      return null;
    }
  }
  
  /// Log an event safely (ignores errors if Firebase is not available)
  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      final analytics = getAnalytics();
      if (analytics != null) {
        await analytics.logEvent(name: name, parameters: parameters);
      }
    } catch (e) {
      print('FirebaseAnalytics logEvent error (ignored): $e');
    }
  }
}

