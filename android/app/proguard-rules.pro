# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Facebook SDK rules
-keep class com.facebook.** { *; }
-keep class com.facebook.android.** { *; }

# Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep custom fonts
-keep class * extends java.lang.Enum { *; }

# Keep Iconsax font classes
-keep class * {
    public static <fields>;
}

# Keep all classes with @Keep annotation
-keep @androidx.annotation.Keep class * { *; }

# Keep all classes in your package
-keep class com.tanmeyah.app.** { *; }

# Keep all model classes (if any)
-keep class * implements java.io.Serializable { *; }

# Keep all classes that might be used via reflection
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep all classes with specific annotations
-keep @interface * { *; }
-keep class * {
    @* <methods>;
}

# Keep all classes that might be used in JSON serialization
-keepclassmembers,allowshrinking,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep all classes that might be used in reflection
-keepclassmembers class * {
    @androidx.annotation.Keep <methods>;
}

# Keep all classes that might be used in reflection
-keepclassmembers class * {
    @androidx.annotation.Keep <fields>;
}

# Google Play Core rules
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }

# Flutter deferred components rules
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }

