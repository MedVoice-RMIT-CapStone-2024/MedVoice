import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppThemeListener with ChangeNotifier {
  static bool darkMode = false;

  ThemeMode currentTheme() {
    return darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    darkMode = !darkMode;
    notifyListeners();
  }
}

class SystemAppTheme {
  static final AppThemeListener systemThemeNotifier = AppThemeListener();
}
