import 'package:flutter/cupertino.dart';
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
    RetypePasswordStrength(strength: 0, strengthLabel: 'Weak'),
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
          'Password successfully changed!', 'Return to login', () {
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
      return 'Password is required';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void updatePasswordStrength(String password) {
    double strength = 0;
    String strengthLabel = 'Weak';

    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[a-z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'\d').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.2;
    if (password.length >= 8) strength += 0.2;

    if (strength < 0.3) {
      strengthLabel = 'Weak';
    } else if (strength < 0.7) {
      strengthLabel = 'Good';
    } else {
      strengthLabel = 'Strong';
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
