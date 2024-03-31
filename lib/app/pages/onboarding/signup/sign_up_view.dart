import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/onboarding/signup/sign_up_controller.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/module_utils.dart';
import '../components/background_set.dart';
import '../components/text_field_container.dart';
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: HexColor("#FBE8F2"),
        body: BackgroundSetUp(
          link: 'assets/images/bg3.png',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: toSize(230)),
              Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: toSize(50),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Sign in to continue",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: toSize(15),
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: toSize(20)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFieldContainer(
                    size: size,
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.all(toSize(8.0)),
                          child: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        labelText: "Email address",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
              ),
              SizedBox(height: toSize(10)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFieldContainer(
                    size: size,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.all(toSize(8.0)),
                          child: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(toSize(8.0)),
                          child: const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: toSize(18),
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
