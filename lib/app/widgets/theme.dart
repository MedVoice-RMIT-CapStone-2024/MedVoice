import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/global.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: HexColor(Global.mColors['blue_18'].toString()),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: HexColor(Global.mColors['blue_19'].toString()),
        onPrimary: Colors.white,
        secondary: HexColor(Global.mColors['gray_17'].toString()),
        onSecondary: HexColor(Global.mColors['blue_20'].toString()),
        background: HexColor(Global.mColors['blue_21'].toString()),
        onBackground: HexColor(Global.mColors['gray_17'].toString()),
        surface: HexColor(Global.mColors['blue_18'].toString()),
        onSurface: HexColor(Global.mColors['gray_18'].toString()),
        error: Colors.yellow,
        onError: Colors.black)
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: HexColor(Global.mColors['gray_18'].toString()),
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: HexColor(Global.mColors['pink_1'].toString()),
        onPrimary: HexColor(Global.mColors['gray_17'].toString()),
        secondary: HexColor(Global.mColors['pink_2'].toString()),
        onSecondary: HexColor(Global.mColors['pink_1'].toString()),
        background: HexColor(Global.mColors['gray_17'].toString()),
        onBackground: HexColor(Global.mColors['white_4'].toString()),
        surface: HexColor(Global.mColors['gray_18'].toString()),
        onSurface: HexColor(Global.mColors['white_4'].toString()),
        error: Colors.yellow,
        onError: Colors.black));
