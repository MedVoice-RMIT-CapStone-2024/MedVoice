import 'package:flutter/material.dart';

import '../../../../common/base_controller.dart';

typedef String? Validator(String? value);

class SignInController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      print('Email: $email');
      print('Email: $password');
      return true;
    }
    return false;
  }
}
