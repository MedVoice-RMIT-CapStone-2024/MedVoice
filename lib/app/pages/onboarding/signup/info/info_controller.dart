import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:med_voice/common/base_controller.dart';

class InfoController extends BaseController {
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

  @override
  void onResumed() {}

  @override
  void onListener() {}

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

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      print('Email: $email');
      print('Password: $password');
      print('Confirm Password: $confirmPassword');
      return true;
    }
    return false;
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
