import 'package:flutter/material.dart'; // Import your theme data
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
