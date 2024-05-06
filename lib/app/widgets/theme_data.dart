import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final darkThemeData = ThemeData.dark().copyWith();

final lightThemeData = ThemeData.light().copyWith(
  primaryColor: Colors.blue,
  hintColor: Colors.blueAccent,
  scaffoldBackgroundColor: HexColor('#F5F5F5'),
);
