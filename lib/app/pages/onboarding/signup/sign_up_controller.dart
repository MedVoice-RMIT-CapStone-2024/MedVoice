import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../common/base_controller.dart';

class SignUpController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {}

// Custom validation functions
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

  bool isStrongPassword(String value) {
    // Define regex patterns for each requirement
    final hasUppercase = RegExp(r'[A-Z]');
    final hasLowercase = RegExp(r'[a-z]');
    final hasDigits = RegExp(r'\d');
    final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    // Check if the input string meets each requirement
    return hasUppercase.hasMatch(value) &&
        hasLowercase.hasMatch(value) &&
        hasDigits.hasMatch(value) &&
        hasSpecialCharacters.hasMatch(value);
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!isStrongPassword(value)) {
      return 'Password must contain uppercase, lowercase, digits, and special characters';
    }
    return null; // Return null if validation passes
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null; // Return null if validation passes
  }

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of birth is required';
    }
    // Additional validation logic for date of birth can be added here
    return null; // Return null if validation passes
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null; // Return null if validation passes
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    dateOfBirthController.dispose();
  }

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      // Extract values from controllers and handle submission logic here
      String email = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;
      String name = nameController.text;
      String dateOfBirth = dateOfBirthController.text;

      // Perform form submission logic (e.g., API call, navigation, etc.)
      // This is where you handle the submitted data
      print('Email: $email');
      print('Password: $password');
      print('Confirm Password: $confirmPassword');
      print('Name: $name');
      print('Date of Birth: $dateOfBirth');
      return true;
    }
    return false;
  }
}
