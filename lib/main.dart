import 'package:flutter/material.dart';
import 'package:med_voice/app/widgets/theme.dart'; // Import your theme data
import 'package:med_voice/app/widgets/theme_data.dart';
import 'package:med_voice/restart_widget.dart';

import 'config/app_config.dart';
import 'config/app_init.dart';

void main() async {
  AppConfig devAppConfig = AppConfig(
    appName: 'MedCare',
    // Add other configuration parameters as needed
  );
  Widget app = await initializeApp(devAppConfig);
  runApp(RestartWidget(child: app));
}

class MyApp extends StatefulWidget {
  final Widget child;

  const MyApp({Key? key, required this.child}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Listen for changes in theme mode
    SystemAppTheme.systemThemeNotifier.addListener(() {
      setState(() {}); // Rebuild the widget tree on theme change
    });
  }

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        themeMode: SystemAppTheme.systemThemeNotifier.currentTheme(),
        darkTheme: darkThemeData, // Define your dark theme data
        theme: lightThemeData, // Define your light theme data
        home: widget.child,
      ),
    );
  }
}
