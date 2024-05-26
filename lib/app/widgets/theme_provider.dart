import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_voice/app/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  ThemeProvider() {
    _loadThemePreference();
  }

  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }

  void _saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }


  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
      _saveThemePreference(true);
    } else {
      _themeData = lightMode;
      _saveThemePreference(false);
    }
    notifyListeners();
  }

  bool get isDarkMode => _themeData == darkMode;
}