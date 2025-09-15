package com.tanmeyah.app
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    fun logSentFriendRequestEvent() {}

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        // Facebook SDK is now initialized in MyApp class
    }
}
