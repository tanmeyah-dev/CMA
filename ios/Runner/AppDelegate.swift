import UIKit
import Flutter
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Debug/verbose Analytics mode is stored on the device and ignores the
    // logger level, so every screen_view and logEvent is printed to the console.
    let defaults = UserDefaults.standard
    defaults.set(false, forKey: "/google/firebase/debug_mode")
    defaults.set(false, forKey: "/google/measurement/debug_mode")
    defaults.set(false, forKey: "/google/measurement/verbose_logging")
    FirebaseConfiguration.shared.setLoggerLevel(.min)
    FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
