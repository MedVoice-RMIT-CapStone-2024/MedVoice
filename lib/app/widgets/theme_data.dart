import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/utils/global.dart';

class MyAppColors {
  static final darkBlue = Color(0xFF1E1E2C);
  static final lightBlue = Color(0xFF2D2D44);
  static final lightGrey = Color(0xFFE5E5E5);
  static final darkGrey = Color(0xFFA1A1A1);
  static final lightGreen = Color(0xFF00C48C);
  static final darkGreen = Color(0xFF00A676);
  static final lightRed = Color(0xFFE74C3C);
  static final darkRed = Color(0xFFC0392B);
  static final lightYellow = Color(0xFFF1C40F);
  static final darkYellow = Color(0xFFD4AC0D);
  static final lightPurple = Color(0xFF9B59B6);
  static final darkPurple = Color(0xFF8E44AD);
  static final pink = Color(0xFFE91E63);
  static final white = Color(0xFFFFFFFF);
}

class MyAppThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Poppins',
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hintColor: Colors.transparent,
    colorScheme: ColorScheme.light(
      primary: HexColor(Global.mColors["pink_1"].toString()),
      onPrimary: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    // primaryColor: HexColor(
    //     Global.mColors['pink_1'].toString()), // Set primary color to white
    // primaryColorDark: Colors.white70, // Use a slightly darker shade of white
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: MyAppColors.darkBlue,
    colorScheme: ColorScheme.dark(
      primary: HexColor(Global.mColors["pink_1"].toString()),
      onPrimary: Colors.white,
    ),
  );

  static ThemeData getTheme(BuildContext context, ThemeMode themeMode) {
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    ThemeMode platformThemeMode = platformBrightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
    ThemeMode effectiveThemeMode =
        themeMode == ThemeMode.system ? platformThemeMode : themeMode;

    return effectiveThemeMode == ThemeMode.dark ? darkTheme : lightTheme;
  }
}
