import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/onboarding/otp_verification/otp_verification_presenter.dart';
import 'package:med_voice/common/base_controller.dart';

import '../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../utils/global.dart';
import '../../../utils/pages.dart';

class OtpVerificationController extends BaseController {
  final OtpVerificationPresenter _presenter;
  final String userEmailAddress;
  int otpDuration = 60;
  int resendDuration = 30;
  Timer? timer;
  Timer? coolDownTimer;
  bool isSent = false;
  bool isAvailableToClick = true;

  OtpVerificationController(nurseRepository, this.userEmailAddress) : _presenter = OtpVerificationPresenter(nurseRepository);

  @override
  void firstLoad() {
    sendOtp(userEmailAddress);
  }

  @override
  void onListener() {
    _presenter.onRegisterNurseSuccess = (NurseInfo response) {
      debugPrint("Register nurse success! Moving to login view...");
      hideLoadingProgress();
      view.showPopupWithAction(
          'Account successfully created! Welcome ${response.mName} to Medvoice!',
          'Confirm', () {
        view.pushScreen(Pages.signIn, isAllowBack: false);
      });
    };
    _presenter.onRegisterNurseFailed = (error) {
      debugPrint("Error registering nurse");
      hideLoadingProgress();
      view.showErrorFromServer("Failed to register this account: $error");
    };
    _presenter.onCompleted = () {
      debugPrint("Register nurse success!");
    };
  }

  void sendOtp(String userEmail) async {
    showLoadingProgress();
    isSent = false;
    EmailOTP.config(
      appName: 'MedVoice',
      otpType: OTPType.numeric,
      expiry : 60000,
      emailTheme: EmailTheme.v6,
      appEmail: 's3803566@rmit.edu.vn',
      otpLength: 5,
    );
    if (await EmailOTP.sendOTP(email: userEmail)) {
      debugPrint("OTP Sent successfully to user: $userEmail");
      ScaffoldMessenger.of(view.context).showSnackBar(
          SnackBar(content: Text("OTP has been sent to $userEmail")));
      hideLoadingProgress();
      isSent = true;
      refreshUI();
      startResendTimer();
      startTimer();
    } else {
      hideLoadingProgress();
      debugPrint("Failed to send OTP");
      ScaffoldMessenger.of(view.context).showSnackBar(
          const SnackBar(content: Text("Failed to send OTP")));
    }
  }

  void otpVerification(String otpCode) async {
    showLoadingProgress();
    if (EmailOTP.verifyOTP(otp: otpCode)) {
      registerNurse();
    } else {
      hideLoadingProgress();
      view.showPopupWithAction('OTP verification failed, please try again', 'Okay');
    }
  }

  void registerNurse() {
    NurseRegisterRequest request = NurseRegisterRequest(
        Global.registerNurseName,
        Global.registerNurseEmail,
        Global.registerNursePassword);

    debugPrint('Email: ${Global.registerNurseEmail}');
    debugPrint('Password: ${Global.registerNursePassword}');

    _presenter.executeUploadLibraryTranscript(request);
  }

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }

  void startTimer() {
    timer?.cancel();
    otpDuration = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (otpDuration > 0) {
        view.setState(() {
          otpDuration--;
        });
      } else {
        timer?.cancel();
      }
    });
  }

  void startResendTimer() {
    coolDownTimer?.cancel();
    resendDuration = 30;
    coolDownTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (resendDuration > 0) {
        view.setState(() {
          resendDuration--;
        });
      } else {
        coolDownTimer?.cancel();
        isAvailableToClick = true;
      }
    });
    refreshUI();
  }
}