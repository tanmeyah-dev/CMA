package com.tanmeyah.app

import android.app.Application
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        
        // Initialize Facebook SDK early in Application lifecycle
        try {
            FacebookSdk.sdkInitialize(applicationContext)
            FacebookSdk.fullyInitialize()
            FacebookSdk.setAutoLogAppEventsEnabled(true)
            FacebookSdk.setAdvertiserIDCollectionEnabled(true)
        } catch (e: Exception) {
            // Handle Facebook SDK initialization errors gracefully
            e.printStackTrace()
        }
    }
}