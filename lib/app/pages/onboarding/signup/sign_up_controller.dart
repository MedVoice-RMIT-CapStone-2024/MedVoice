import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_voice/app/utils/module_utils.dart';
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
      return toText("signUpChooseDateOfBirth");
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return toText("signUpFieldIsRequired");
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return toText("signUpFieldAcceptCharacters");
    }
    return null;
  }

  bool submitForm() {
    if (formKey.currentState!.validate()) {
      String fName = fNameController.text;
      String lName = lNameController.text;

      Global.userCredentials.name = '$fName $lName';
      return true;
    }
    return false;
  }
}
