import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/onboarding/otp_verification/otp_verification_presenter.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';

import '../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../utils/global.dart';
import '../../../utils/pages.dart';

class OtpVerificationController extends BaseController {
  final OtpVerificationPresenter _presenter;
  final bool isFromEmailChange;
  final bool isFromPasswordReset;
  int otpDuration = 60;
  int resendDuration = 30;
  Timer? timer;
  Timer? coolDownTimer;
  bool isSent = false;
  bool isAvailableToClick = true;

  OtpVerificationController(
      nurseRepository, this.isFromEmailChange, this.isFromPasswordReset)
      : _presenter = OtpVerificationPresenter(nurseRepository);

  @override
  void firstLoad() {
    if (!isFromEmailChange || isFromPasswordReset) {
      sendOtp(Global.userCredentials.email ?? "");
    } else if (!isFromPasswordReset) {
      sendOtp(Global.editUserCredentials.email ?? "");
    } else {
      sendOtp(Global.userCredentials.email ?? "");
    }
  }

  @override
  void onListener() {
    _presenter.onRegisterNurseSuccess = (NurseInfo response) {
      debugPrint("Register nurse success! Moving to login view...");
      hideLoadingProgress();
      if (response.mDetail != null) {
        if (response.mDetail!.isNotEmpty) {
          view.onGeneralError(response.mDetail);
        }
      } else {
        view.showPopupWithAction(
            '${toText("infoPopUpActionWelcome")} ${response.mName}',
            'Confirm', () {
          view.pushScreen(Pages.signIn, isAllowBack: false);
        });
      }
    };
    _presenter.onRegisterNurseFailed = (error) {
      debugPrint("Error registering nurse");
      hideLoadingProgress();
      view.showErrorFromServer("Email has already taken");
    };
    _presenter.onChangeEmailSuccess = (NurseInfo response) {
      debugPrint("Change email success");
      hideLoadingProgress();
      if (response.mDetail != null) {
        if (response.mDetail!.isNotEmpty) {
          view.onGeneralError(response.mDetail);
        }
      } else {
        view.showPopupWithAction(toText("OTPVerificationEmailChanged"), toText("newPasswordControllerReturnToLogin"),
            () {
          view.pushScreen(Pages.signIn, isAllowBack: false);
        });
      }
    };
    _presenter.onChangeEmailFailed = (e) {
      debugPrint("Failed to change email");
      view.onGeneralError('Failed to change email $e');
      hideLoadingProgress();
    };
    _presenter.onCompleted = () {
      debugPrint("Register nurse success!");
    };
  }

  void sendOtp(String userEmail) async {
    showLoadingProgress(loadingContent: toText("showLoadingSendingOTP"));
    isSent = false;
    EmailOTP.config(
      appName: 'MedVoice',
      otpType: OTPType.numeric,
      expiry: 60000,
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
      ScaffoldMessenger.of(view.context)
          .showSnackBar(const SnackBar(content: Text("Failed to send OTP")));
    }
  }

  void otpVerification(String otpCode) async {
    showLoadingProgress(loadingContent: toText("showLoadingVerifyingOTP"));
    if (EmailOTP.verifyOTP(otp: otpCode)) {
      if (isFromPasswordReset) {
        view.pushScreen(Pages.newPasswordView);
      } else {
        if (isFromEmailChange) {
          changeEmailNurse(Global.editUserCredentials.email ?? "");
        } else {
          registerNurse();
        }
      }
    } else {
      hideLoadingProgress();
      view.showPopupWithAction(
          toText("OTPVerificationEmailFailed"), 'Okay');
    }
  }

  void registerNurse() {
    NurseRegisterRequest request = NurseRegisterRequest(
        '',
        Global.userCredentials.email,
        Global.userCredentials.password,
        null);
    _presenter.executeCreateNurseAccount(request);
  }

  void changeEmailNurse(String newEmail) {
    if (Global.editUserCredentials.name != null) {
      if (Global.editUserCredentials.name!.isEmpty) {
        Global.editUserCredentials.name = Global.userCredentials.name;
      }
    }
    if (Global.editUserCredentials.password != null) {
      if (Global.editUserCredentials.password!.isEmpty) {
        Global.editUserCredentials.password = Global.userCredentials.password;
      }
    }
    if (Global.editUserCredentials.id != null) {
      if (Global.editUserCredentials.id!.isEmpty) {
        Global.editUserCredentials.id = Global.userCredentials.id;
      }
    }
    NurseRegisterRequest request = NurseRegisterRequest(
        Global.editUserCredentials.name,
        newEmail,
        Global.editUserCredentials.password,
        Global.editUserCredentials.id);
    _presenter.executeEditEmail(request);
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
