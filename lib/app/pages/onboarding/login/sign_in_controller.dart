import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/base_controller.dart';
import '../../../utils/pages.dart';


typedef String? Validator(String? value);

class SignInController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isAuthenticated = false;
  LocalAuthentication auth = LocalAuthentication();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {}

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required';
    }
    // Validate email format using regex
    if (!value.contains('@') &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null; // Return null if validation passes
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // Add additional validation logic for password (e.g., minimum length, strength)
    return null; // Return null if validation passes
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      // Extract values from controllers and handle submission logic here
      String email = emailController.text;
      String password = passwordController.text;

      // Perform form submission logic (e.g., API call, navigation, etc.)
      // This is where you handle the submitted data
      debugPrint('Email: $email');
      debugPrint('Password: $password');
      saveCredentials();
      return true;
    }
    return false;
  }

  Future<void> saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginEmail', emailController.text);
    await prefs.setString('loginPassword', passwordController.text);
    refreshUI();
    view.showPopupWithAction('Email: ${emailController.text} \nPassword: ${passwordController.text}', 'Okay', (){}, 'Credentials saved');
  }

  Future<void> fetchCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('bioLoginEmail');
    String? password = prefs.getString('bioLoginPassword');
    bool? bioConfig = prefs.getBool('bioToggle');
    debugPrint('Email: $email \nPassword: $password \nBio Config: $bioConfig');
    if (email != null && password != null) {
      if (email.isEmpty && password.isEmpty) {
        view.onGeneralError('No account has linked with your biometrics');
      } else {
        emailController.text = email;
        passwordController.text = password;
        view.pushScreen(Pages.main, isAllowBack: false);
        refreshUI();
      }
    } else {
      view.onGeneralError('No account has linked with your biometrics');
    }
  }

  Future<void> onLogInThroughBioAuth() async {
    final bool canAuthenticateBiometrics =
        await auth.canCheckBiometrics;
    if (canAuthenticateBiometrics) {
      final bool deviceEnabledAuth =
          await auth.isDeviceSupported();
      if (deviceEnabledAuth) {
        final bool didAuthenticated =
            await auth.authenticate(
            localizedReason:
            'Enable for a faster login',
            options: const AuthenticationOptions(
                biometricOnly: true));
        if (didAuthenticated) {
          fetchCredentials();
        } else {
          view.onGeneralError(
              'Authenticated failed, please try again!');
        }
      } else {
        view.onGeneralError(
            'Your device has not set up bio authentication yet!');
      }
    } else {
      view.onGeneralError(
          'Your device does not support authentication!');
    }
  }
}
