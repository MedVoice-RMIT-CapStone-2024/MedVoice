import 'package:flutter/cupertino.dart';
import 'package:med_voice/common/base_controller.dart';

import '../../../../../utils/global.dart';
import '../../../../../utils/module_utils.dart';

class ChangeNurseEmailController extends BaseController {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void firstLoad() {}

  @override
  void onListener() {}

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return toText("changeNurseEmailEmailRequired");
    }
    // Validate email format using regex
    if (!value.contains('@') &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return toText("changeNurseEmailEmailFormat");
    }
    return null; // Return null if validation passes
  }

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      debugPrint('Email: $email');
      Global.editUserCredentials.email = email;
      return true;
    }
    return false;
  }
}