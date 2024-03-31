import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/app/pages/onboarding/signup/sign_up_controller.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../login/sign_in_controller.dart';

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
    return false;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    SignUpController _controller = controller as SignUpController;
    return Container();
  }
}
