import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../common/base_controller.dart';

class SignUpController extends BaseController {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {}

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of birth is required';
    }
    // Additional validation logic for date of birth can be added here
    return null; // Return null if validation passes
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'This field can only contain letters and spaces';
    }
    return null; // Return null if validation passes
  }

  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    dateOfBirthController.dispose();
  }

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      // Extract values from controllers and handle submission logic here
      String fname = fnameController.text;
      String lname = lnameController.text;
      String dateOfBirth = dateOfBirthController.text;

      // Perform form submission logic (e.g., API call, navigation, etc.)
      // This is where you handle the submitted data
      print('Name: $fname $lname');
      print('Date of Birth: $dateOfBirth');
      return true;
    }
    return false;
  }
}
