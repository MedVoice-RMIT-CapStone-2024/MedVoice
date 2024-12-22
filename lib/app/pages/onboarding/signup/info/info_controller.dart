import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/onboarding/otp_verification/otp_verification_view.dart';
import 'package:med_voice/app/pages/onboarding/signup/info/info_presenter.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';

import '../../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../utils/global.dart';
import '../../../../utils/module_utils.dart';
import '../../../../utils/pages.dart';

class InfoController extends BaseController {
  final InfoPresenter _presenter;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
  ValueNotifier<PasswordStrength> passwordStrengthNotifier =
      ValueNotifier<PasswordStrength>(
    PasswordStrength(strength: 0, strengthLabel: toText("infoWeakLevel")),
  );

  InfoController(nurseRepository) : _presenter = InfoPresenter(nurseRepository);

  @override
  void onResumed() {}

  @override
  void onListener() {
    _presenter.onRegisterNurseSuccess = (NurseInfo response) {
      debugPrint("Register nurse success! Moving to login view...");
      hideLoadingProgress();
      view.showPopupWithAction(
          '${toText("infoPopUpActionWelcome")} ${response.mName}',
          toText("infoPopUpReturnToLogin"), () {
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

  @override
  void firstLoad() {}

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void updatePasswordStrength(String password) {
    double strength = 0;
    String strengthLabel = toText("infoWeakLevel");

    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[a-z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'\d').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.2;
    if (password.length >= 8) strength += 0.2;

    if (strength < 0.3) {
      strengthLabel = toText("infoWeakLevel");
    } else if (strength < 0.7) {
      strengthLabel = toText("infoGoodLevel");
    } else {
      strengthLabel = toText("infoStrongLevel");
    }

    passwordStrengthNotifier.value =
        PasswordStrength(strength: strength, strengthLabel: strengthLabel);
  }

  // Custom validation functions
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return toText("infoErrorEmailNeeded");
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return toText("infoErrorInvalidEmail");
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return toText("infoErrorPasswordNeeded");
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return toText("infoErrorEmptyReconfirm");
    }
    if (value != passwordController.text) {
      return toText("infoErrorMissMatchPassword");
    }
    return null;
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      Global.userCredentials.email = emailController.text.toLowerCase();
      Global.userCredentials.password = passwordController.text;
      view.pushScreen(Pages.otpVerification, arguments: {
        isFromEmailChange: false,
        isFromPasswordReset: false,
      });
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    obscureText.dispose();
    passwordStrengthNotifier.dispose();
  }
}

class PasswordStrength {
  final double strength;
  final String strengthLabel;

  PasswordStrength({required this.strength, required this.strengthLabel});
}
