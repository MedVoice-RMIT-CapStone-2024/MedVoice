import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/onboarding/signup/info/info_presenter.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';

import '../../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../utils/global.dart';
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
    PasswordStrength(strength: 0, strengthLabel: 'Weak'),
  );

  InfoController(nurseRepository) : _presenter = InfoPresenter(nurseRepository);

  @override
  void onResumed() {}

  @override
  void onListener() {
    _presenter.onRegisterNurseSuccess = (NurseInfo response) {
      debugPrint("Register nurse success! Moving to login view...");
      hideLoadingProgress();
      view.showPopupWithAction('Account successfully created! Welcome ${response.mName} to Medvoice!', 'Confirm', (){
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

    passwordStrengthNotifier.value =
        PasswordStrength(strength: strength, strengthLabel: strengthLabel);
  }

  // Custom validation functions
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
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

  void submitForm() {
    showLoadingProgress();
    if (formKey.currentState!.validate()) {
      Global.registerNurseEmail = emailController.text;
      Global.registerNursePassword = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      NurseRegisterRequest request = NurseRegisterRequest(
          Global.registerNurseName,
          Global.registerNurseEmail,
          Global.registerNursePassword);

      debugPrint('Email: ${Global.registerNurseEmail}');
      debugPrint('Password: ${Global.registerNursePassword}');
      debugPrint('Confirm Password: $confirmPassword');

      _presenter.executeUploadLibraryTranscript(request);
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
