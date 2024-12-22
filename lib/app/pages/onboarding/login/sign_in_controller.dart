import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:med_voice/app/pages/onboarding/login/sign_in_presenter.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/domain/entities/nurse/nurse_login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/base_controller.dart';
import '../../../../domain/entities/nurse/nurse_login_info.dart';
import '../../../utils/global.dart';
import '../../../utils/pages.dart';


typedef Validator = String? Function(String? value);

class SignInController extends BaseController {
  final SignInPresenter _presenter;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAuthenticated = false;
  LocalAuthentication auth = LocalAuthentication();
  NurseLoginRequest request = NurseLoginRequest.buildDefault();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignInController(nurseRepository) : _presenter = SignInPresenter(nurseRepository);

  @override
  void onResumed() {}

  @override
  void onListener() {
    _presenter.onLoginNurseSucceed = (NurseLoginInfo response) {
      debugPrint("Login nurse success");
      Global.userCredentials.id = response.mNurseId.toString();
      Global.userCredentials.email = emailController.text;
      Global.userCredentials.password = passwordController.text;
      hideLoadingProgress();
      if (response.mDetail != null) {
        if (response.mDetail!.isNotEmpty) {
          view.onGeneralError(response.mDetail);
        }
      } else {
        view.pushScreen(Pages.main, isAllowBack: false);
      }
    };
    _presenter.onLoginNurseFailed = (e) {
      debugPrint("Login nurse failed");
      hideLoadingProgress();
      view.onGeneralError('Failed to login $e');
    };
    _presenter.onCompleted = () {
      debugPrint("Login complete");
    };
  }

  @override
  void firstLoad() {}

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return toText("changeNurseEmailEmailRequired");
    }
    if (!value.contains('@') &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return toText("changeNurseEmailEmailFormat");
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return toText("changeNursePasswordRequired");
    }
    return null;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

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
        onLogin(emailController.text, passwordController.text);
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

  void onLogin(String email, String password) {
    showLoadingProgress();
    request.email = emailController.text;
    request.password = passwordController.text;

    // TODO: Remove the Global.admin when the app is distributed
    // if (request.email == Global.adminEmail && request.password == Global.adminPassword){
    //   hideLoadingProgress();
    //   view.pushScreen(Pages.main, isAllowBack: false);
    // } else {
    //   _presenter.executeLoginNurseAccount(request);
    // }

    _presenter.executeLoginNurseAccount(request);
  }
}
