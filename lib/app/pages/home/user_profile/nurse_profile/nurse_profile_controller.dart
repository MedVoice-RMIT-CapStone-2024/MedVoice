import 'dart:async';

import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/user_profile/nurse_profile/nurse_profile_presenter.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/domain/entities/nurse/nurse_info.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/base_controller.dart';
import '../../../../utils/global.dart';

class NurseProfileController extends BaseController {
  final NurseProfilePresenter _presenter;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool toggleBioAuth = false;

  bool isShowStartButton = false;
  Timer? timer;
  ThemeMode themeMode = ThemeMode.system;

  NurseProfileController(nurseRepository)
      : _presenter = NurseProfilePresenter(nurseRepository);

  @override
  void onResumed() {}

  @override
  void onListener() {
    _presenter.onGetNurseInfoSucceed = (NurseInfo response) {
      Global.userCredentials.id = response.mId.toString();
      Global.userCredentials.name = response.mName;
      Global.userCredentials.email = response.mEmail;
      fetchPriorCredentials();
      debugPrint("Fetch nurse data success");
      hideLoadingProgress();
    };
    _presenter.onGetNurseInfoFailed = (e) {
      debugPrint("Fetch nurse data failed");
      hideLoadingProgress();
      view.showErrorFromServer(
          "Failed to fetch information\nPlease try again later");
    };
    _presenter.onCompleted = () {
      debugPrint("Finished fetching nurse data");
    };
  }

  @override
  void firstLoad() {
    onLoadNurseInfo();
  }

  Future<void> saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bioLoginEmail', emailController.text);
    await prefs.setString('bioLoginPassword', passwordController.text);
    view.showPopupWithAction(
        'Email: ${emailController.text} \nPassword: ${passwordController.text}',
        'Okay',
        () {},
        toText("nurseProfileCredentialsLinked"));
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
        toText("nurseProfileEnableFaceID"), 'Ok', () {
      fetchCredentials();
      refreshUI();
    }, toText("nurseProfileEnableFaceIDConfirmation"), toText("nurseProfileEnableFaceIDCancel"), () {});
  }

  void onTurningOffBioAuth() {
    view.showPopupWithAction(
        toText("nurseProfileDisableFaceID"), 'Ok', () {
      resetBioCredentials();
      refreshUI();
    }, toText("nurseProfileDisableFaceIDConfirmation"), toText("nurseProfileEnableFaceIDCancel"), () {});
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

  void onLoadNurseInfo() {
    showLoadingProgress(loadingContent: toText("showLoadingFetchingNurseInfo"));
    NurseRegisterRequest request = NurseRegisterRequest.buildDefault();
    request.id = Global.userCredentials.id.toString();
    debugPrint("Request id: ${request.id}");
    _presenter.executeGetNurseInfo(request);
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
