import 'package:flutter/cupertino.dart';

import '../../../../common/base_controller.dart';
import '../../../utils/global.dart';
import '../../../utils/pages.dart';
import '../otp_verification/otp_verification_view.dart';

class ResetController extends BaseController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

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
    if (!value.contains('@') &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      Global.userCredentials.email = emailController.text.toLowerCase();
      view.pushScreen(Pages.otpVerification, arguments: {
        isFromEmailChange: false,
        isFromPasswordReset: true
      });
    }
  }
}
