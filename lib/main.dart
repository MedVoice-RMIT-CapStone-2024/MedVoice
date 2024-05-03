import 'package:flutter/material.dart';
import 'package:med_voice/restart_widget.dart';

import 'config/app_config.dart';
import 'config/app_init.dart';

Future<void> main() async {
  AppConfig devAppConfig = AppConfig(
    appName: 'MedCare',
  );
  Widget app = await initializeApp(devAppConfig);
  runApp(RestartWidget(child: app));
}
