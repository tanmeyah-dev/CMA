package com.tanmeyah.app
import android.os.Bundle
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    fun logSentFriendRequestEvent() {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Facebook SDK is now initialized in MyApp class
        // Just activate app events here
        try {
            AppEventsLogger.activateApp(application)
        } catch (e: Exception) {
            // Handle Facebook SDK errors gracefully
            e.printStackTrace()
        }
    }
}
