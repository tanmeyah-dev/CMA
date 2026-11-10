# Please add these rules to your existing keep rules in order to suppress warnings.
# Generated / required for release R8 with Flutter + Firebase + ML Kit.

# firebase-iid is excluded (duplicates firebase-messaging classes).
-dontwarn com.google.firebase.iid.FirebaseInstanceId
-dontwarn com.google.firebase.iid.**

# Deprecated Google Credentials / Smart Lock APIs referenced by older SDKs.
-dontwarn com.google.android.gms.auth.api.credentials.Credential$Builder
-dontwarn com.google.android.gms.auth.api.credentials.Credential
-dontwarn com.google.android.gms.auth.api.credentials.CredentialPickerConfig$Builder
-dontwarn com.google.android.gms.auth.api.credentials.CredentialPickerConfig
-dontwarn com.google.android.gms.auth.api.credentials.CredentialRequest$Builder
-dontwarn com.google.android.gms.auth.api.credentials.CredentialRequest
-dontwarn com.google.android.gms.auth.api.credentials.CredentialRequestResponse
-dontwarn com.google.android.gms.auth.api.credentials.Credentials
-dontwarn com.google.android.gms.auth.api.credentials.CredentialsClient
-dontwarn com.google.android.gms.auth.api.credentials.HintRequest$Builder
-dontwarn com.google.android.gms.auth.api.credentials.HintRequest

# Flutter Play Store deferred components (not used by this app).
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-dontwarn com.google.android.play.core.**

# Talsec freeRASP. Keep the SDK so release shrinking does not remove it.
-keep class com.aheaditec.talsec.** { *; }
-keep class com.aheaditec.freerasp.** { *; }
-dontwarn com.aheaditec.talsec.**
-dontwarn com.aheaditec.freerasp.**

# Flutter / plugins commonly needed with minify enabled.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Google Sign-In uses Credential Manager. Release shrinking removes these
# classes and the sign-in call fails while debug (no minify) still works.
-keep class androidx.credentials.** { *; }
-keep class com.google.android.libraries.identity.googleid.** { *; }
-dontwarn androidx.credentials.**
-dontwarn com.google.android.libraries.identity.googleid.**

# ML Kit (vlens)
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.internal.mlkit_** { *; }

# Facebook / Adjust SDKs used by the app
-keep class com.facebook.** { *; }
-keep class com.adjust.sdk.** { *; }
-dontwarn com.facebook.**
-dontwarn com.adjust.sdk.**
