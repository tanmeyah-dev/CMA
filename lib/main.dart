// ignore_for_file: depend_on_referenced_packages

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
import 'Shared/shared_prefirences.dart';
import 'Shared/shard_obj.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Utilities/debug_tls.dart';
import 'Utilities/routing.dart';
import 'Utilities/runtime_protection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:bot_toast/bot_toast.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // UpdateApp.startFlexibleUpdate();

  try {
    await SharedObj().init();
    await SharedPref.loadSession();
  } catch (e) {
    debugPrint('Error initializing SharedObj: $e');
  }

  try {
    DartPingIOS.register();
    // Ping operation wrapped in try-catch to prevent crashes
    var pings = Ping('gateway.tanmeyah.com', count: 4);
    pings.stream
        .timeout(
      const Duration(seconds: 10),
      onTimeout: (sink) {
        debugPrint('Ping operation timed out');
        sink.close();
      },
    )
        .listen(
      (ping) {
        debugPrint(">>>><<<<<");
        debugPrint(ping.toString());
      },
      onError: (error) {
        debugPrint('Ping error: $error');
      },
      onDone: () {
        debugPrint('Ping stream completed');
      },
      cancelOnError: true,
    );
  } catch (e) {
    debugPrint('Error setting up ping: $e');
    // Continue app initialization even if ping fails
  }

  installDebugTlsOverride();

  await startRuntimeProtection();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
    // Decide if you want to continue or exit
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
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  // Must be created once — recreating BotToastInit on rebuild causes
  // GlobalKey conflicts with Modular's Navigator (esp. after hot restart).
  final TransitionBuilder _botToastBuilder = BotToastInit();
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  late final List<NavigatorObserver> _navigatorObservers = [
    FirebaseAnalyticsObserver(analytics: _analytics),
    BotToastNavigatorObserver(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<AppLanguage>(context, listen: false).fetchLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: runtimeProtectionBlocked,
      builder: (context, blocked, _) {
        if (blocked) {
          return const RuntimeProtectionBlock();
        }
        return _buildApp(context);
      },
    );
  }

  Widget _buildApp(BuildContext context) {
    final appLan = Provider.of<AppLanguage>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, __) {
        return MaterialApp(
          theme: ThemeData(fontFamily: 'DINNextLTArabic-Regular'),
          // Modular's .modular() owns the navigator via RouterDelegate;
          // do not pass a separate navigatorKey (causes duplicate GlobalKey).
          scaffoldMessengerKey: SharedObj.rootScaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            // Flutter 3.47 asserts when a rebuild mounts a second iOS system
            // text menu. Keep the Flutter selection toolbar instead.
            final mediaQuery = MediaQuery.of(context).copyWith(
              supportsShowingSystemContextMenu: false,
            );
            return MediaQuery(
              data: mediaQuery,
              child: _botToastBuilder(context, child),
            );
          },
          title: appLan.appLanguage == Languages.ar
              ? 'تنميه'
              : "Tanmeyah",
          navigatorObservers: _navigatorObservers,
          initialRoute: SplashScreen.routeName,
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


