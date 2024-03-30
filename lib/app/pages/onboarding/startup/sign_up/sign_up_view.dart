import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/onboarding/startup/sign_up/sign_up_controller.dart';
import 'package:med_voice/app/pages/onboarding/startup/startup_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';

class SignUpView extends View {
  SignUpView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpView();
  }
}

class _SignUpView extends BaseStateView<SignUpView, SignUpController> {
  _SignUpView() : super(SignUpController());

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  bool isHideBackButton() {
    return false;
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    SignUpController _controller = controller as SignUpController;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: toSize(40)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 400,
          ),
          ok(),
          SizedBox(
            height: 30,
          ),
          ok(),
        ]),
      ),
    );
  }

  Container ok() {
    return Container(
      width: 335,
      child: TextFormField(
        autofocus: true,
        obscureText: false,
        decoration: InputDecoration(
          isDense: false,
          labelText: 'Email Address',
          alignLabelWithHint: false,
          hintText: 'Enter your email',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
        ),
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: null,
      ),
    );
  }
}
