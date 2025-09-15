package com.tanmeyah.app

import android.app.Application
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        
        // Initialize Facebook SDK
        FacebookSdk.sdkInitialize(applicationContext)
        AppEventsLogger.activateApp(this)
        FacebookSdk.fullyInitialize()
        FacebookSdk.setAutoLogAppEventsEnabled(true)
        FacebookSdk.setAdvertiserIDCollectionEnabled(true)
        
        // Log the App ID for debugging
        val appId = FacebookSdk.getApplicationId()
        android.util.Log.d("MyApp", "Facebook App ID: $appId")
    }
}