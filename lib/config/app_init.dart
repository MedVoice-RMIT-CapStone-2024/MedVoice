import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/widgets/theme_data.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../app/pages/onboarding/startup/startup_view.dart';
import '../app/utils/global.dart';
import 'dart:async';

import 'app_config.dart';

Future<Widget> initializeApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initFirebase(appConfig);
  await getAppVersion();
  await getDeviceLang();
  return MyApp(appConfig);
}

class MyApp extends StatefulWidget {
  final AppConfig appConfig;

  MyApp(this.appConfig, {Key? key}) : super(key: key) {
    //set base url
    //Constants.baseUrl = appConfig.baseURL;
    //Global.mGoogleKey = appConfig.googleKey;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Timer? _timer;
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("App is return");
        _startTimer();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        debugPrint("App is pause");
        _stopTimer(); // Conservatively set a timer on all three
        break;
    }
  }

  void _startTimer() {
    _timer ??= Timer.periodic(const Duration(minutes: 5), (timer) {});
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedCare',
      darkTheme: ThemeData(
        useMaterial3: true,

        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          primary: HexColor("#EC4B8B"),
          onPrimary: HexColor("#FEF9EC"),
          background: HexColor("#0D0221"),
          secondary: HexColor("#FDE8E9"),
          onSecondary: HexColor("#FEF9EC"),
          tertiary: HexColor("#0099CC"),
          onBackground: HexColor("#0D0221"),
          // ···
          brightness: Brightness.dark,
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hintColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          background: HexColor("#FEF9EC"),
          onBackground: HexColor("#EC4B8B"),
          primary: HexColor(Global.mColors["pink_1"].toString()),
          onPrimary: HexColor("#1F2232"),
          secondary:
              HexColor(Global.mColors['pink_1'].toString()).withOpacity(0.2),
          onSecondary: HexColor("#0D0221"),
        ),
      ),
      themeMode: ThemeMode.system,
      home: StartupView(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}

Future<void> getAppVersion() async {
  /// App version
  final info = await PackageInfo.fromPlatform();
  Global.appVersion = info.version;
}

/// Get device language to set for app language
Future<void> getDeviceLang() async {
  Global.mLang = window.locale.languageCode;
}
