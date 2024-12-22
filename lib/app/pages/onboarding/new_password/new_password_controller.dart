import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';

import '../../../../domain/entities/nurse/nurse_info.dart';
import '../../../utils/global.dart';
import '../../../utils/pages.dart';
import 'new_password_presenter.dart';

class NewPasswordController extends BaseController {
  final NewPasswordPresenter _presenter;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
  ValueNotifier<RetypePasswordStrength> passwordStrengthNotifier =
      ValueNotifier<RetypePasswordStrength>(
    RetypePasswordStrength(strength: 0, strengthLabel: toText("infoWeakLevel")),
  );
  final TextEditingController confirmPasswordController =
      TextEditingController();

  NewPasswordController(nurseRepository)
      : _presenter = NewPasswordPresenter(nurseRepository);
  @override
  void firstLoad() {}

  @override
  void onListener() {
    _presenter.onChangePasswordSuccess = (NurseInfo response) {
      hideLoadingProgress();
      debugPrint("Change nurse password success");
      view.showPopupWithAction(
          toText("newPasswordControllerConfirmChange"), toText("newPasswordControllerReturnToLogin"), () {
        view.pushScreen(Pages.signIn);
      });
    };
    _presenter.onChangePasswordFailed = (e) {
      hideLoadingProgress();
      debugPrint("Change nurse password failed");
      view.showErrorFromServer("Failed to reset password $e");
    };
    _presenter.onCompleted = () {
      debugPrint("Change password complete");
    };
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return toText("changeNursePasswordRequired");
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return toText("changeNursePasswordConfirm");
    }
    if (value != passwordController.text) {
      return toText("changeNursePasswordNotMatch");
    }
    return null;
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

    passwordStrengthNotifier.value = RetypePasswordStrength(
        strength: strength, strengthLabel: strengthLabel);
  }

  void submitForm() {
    showLoadingProgress();
    if (formKey.currentState!.validate()) {
      Global.userCredentials.password = passwordController.text;
      _presenter.executeEditPassword(Global.userCredentials);
    }
  }
}

class RetypePasswordStrength {
  final double strength;
  final String strengthLabel;

  RetypePasswordStrength({required this.strength, required this.strengthLabel});
}
