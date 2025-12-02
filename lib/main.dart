// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'Cache/app_languages.dart';
import 'Cache/shared_data_provider.dart';
import 'Cache/locales.dart';
import 'Modules/Authentication/Splash/splash_screen.dart';
import 'Shared/shard_obj.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Utilities/routing.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:firebase_analytics/observer.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // UpdateApp.startFlexibleUpdate();

  await SharedObj().init();
  DartPingIOS.register();
  var pings = await Ping('gateway.tanmeyah.com',count: 4);
  pings.stream.listen((ping) {
    print(">>>><<<<<");
    print(ping);
  });
  HttpOverrides.global = MyHttpOverrides();

  // Initialize Firebase with error handling
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error (ignored): $e');
    // Try to initialize with a minimal default app to prevent "no-app" errors
    try {
      if (Firebase.apps.isEmpty) {
        // Create a minimal default app if possible
        await Firebase.initializeApp(
          name: '[DEFAULT]',
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
    } catch (e2) {
      print('Firebase fallback initialization also failed (ignored): $e2');
      // Continue app execution even if Firebase fails to initialize
    }
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
      ChangeNotifierProvider<SharedDataProvider>(
          create: (_) => SharedDataProvider()),
    ],
    child: ModularApp(
      module: AppModule(),
      child: const EntryPoint(),
    ),
  ));
}

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}
//with WidgetsBindingObserver
class _EntryPointState extends State<EntryPoint>  {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    FirebaseAnalytics? _analytics;
    try {
      _analytics = FirebaseAnalytics.instance;
    } catch (e) {
      print('FirebaseAnalytics initialization error (ignored): $e');
    }
    final appLan = Provider.of<AppLanguage>(context);
    appLan.fetchLocale();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (_, __) {
        // FlutterNativeSplash.remove();
        return  MaterialApp(
          theme: ThemeData(fontFamily: 'DINNextLTArabic-Regular'),
          navigatorKey: SharedObj.navigatorKey,
          scaffoldMessengerKey:SharedObj.rootScaffoldMessengerKey ,
          debugShowCheckedModeBanner: false,
          title: appLan.appLanguage == Languages.ar
              ? 'تنميه'
              : "Tanmeyah",
          navigatorObservers: _analytics != null
              ? [
                  FirebaseAnalyticsObserver(analytics: _analytics),
                ]
              : [],
          initialRoute: SplashScreen.routeName,
          // locale: appLan.appLocal,
          locale: appLan.appLocal,
          supportedLocales: Languages.values.map((e) => Locale(e.name)).toList(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate
          ],
        ).modular();
      },
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

