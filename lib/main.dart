import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import your theme data
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:med_voice/restart_widget.dart';
import 'package:provider/provider.dart';
import 'config/app_config.dart';
import 'config/app_init.dart';

void main() async {
  AppConfig devAppConfig = AppConfig(
    appName: 'MedCare',
    // Add other configuration parameters as needed
  );
  Widget app = await initializeApp(devAppConfig);
  runApp(BetterFeedback(
    theme: FeedbackThemeData(
      background: Colors.grey,
      feedbackSheetColor: Colors.grey[50]!,
      drawColors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
    ),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalFeedbackLocalizationsDelegate(),
    ],
    mode: FeedbackMode.draw,
    child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(), child: RestartWidget(child: app)),
  ));
}
