import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../common/base_controller.dart';
import '../../../utils/global.dart';

class SignUpController extends BaseController {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
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
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'This field can only contain letters and spaces';
    }
    return null;
  }

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      String fname = fNameController.text;
      String lname = lNameController.text;

      Global.registerNurseName = '$fname $lname';
      debugPrint('Name: ${Global.registerNurseName}');
      return true;
    }
    return false;
  }
}
