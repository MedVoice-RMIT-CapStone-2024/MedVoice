import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/base_controller.dart';

class NurseProfileController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool toggleBioAuth = false;

  bool isShowStartButton = false;
  Timer? timer;
  ThemeMode themeMode = ThemeMode.system;

  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {
    fetchPriorCredentials();
  }

  Future<void> saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bioLoginEmail', emailController.text);
    await prefs.setString('bioLoginPassword', passwordController.text);
    view.showPopupWithAction(
        'Email: ${emailController.text} \nPassword: ${passwordController.text}',
        'Okay',
        () {},
        'Credentials saved');
    refreshUI();
    saveBioConfig();
  }

  Future<void> fetchCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('loginEmail');
    String? password = prefs.getString('loginPassword');
    emailController.text = email ?? '';
    passwordController.text = password ?? '';
    debugPrint(
        'Email: ${emailController.text} \nPassword: ${passwordController.text}');
    refreshUI();
    saveCredentials();
  }

  void onTurningOnBioAuth() {
    view.showPopupWithAction(
        'Enable Biometric Authentication for this account?', 'Ok', () {
      fetchCredentials();
      refreshUI();
    }, 'Enable Bio Authentication', 'Cancel', () {});
  }

  void onTurningOffBioAuth() {
    view.showPopupWithAction(
        'Disable Biometric Authentication for this account?', 'Ok', () {
      resetBioCredentials();
      refreshUI();
    }, 'Disable Bio Authentication', 'Cancel', () {});
  }

  Future<void> saveBioConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bioToggle', true);
    toggleBioAuth = true;
    refreshUI();
  }

  // Fetch both email storage and compare them to fetch the bio configurations
  Future<void> fetchPriorCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bioEmail = prefs.getString('bioLoginEmail');
    String? email = prefs.getString('loginEmail');
    if (email != null && bioEmail != null) {
      if (bioEmail.isNotEmpty) {
        if (bioEmail == email) {
          if (prefs.getBool('bioToggle') != null) {
            toggleBioAuth = prefs.getBool('bioToggle')!;
          } else {
            view.onGeneralError('Could not fetch data');
          }
        }
      }
    }
    refreshUI();
  }

  Future<void> resetBioCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bioLoginEmail', '');
    await prefs.setString('bioLoginPassword', '');
    await prefs.setBool('bioToggle', false);
    toggleBioAuth = false;
    refreshUI();
  }
}
