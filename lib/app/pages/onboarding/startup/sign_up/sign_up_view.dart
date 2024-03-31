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
    return false;
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
    // const double defaultPadding = 16.0;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor:
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: toSize(5)),
                // Image
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: toSize(150),
                    width: toSize(150),
                    child: Image.asset(
                      'assets/images/medVoice.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: toSize(300)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFieldContainer(
                      size: size,
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              color: HexColor("#EC4B8B"),
                            ),
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: HexColor("#EC4B8B"),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.lock,
                              color: HexColor("#EC4B8B"),
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.visibility,
                              color: HexColor("#EC4B8B"),
                            ),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: HexColor("#EC4B8B"),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                      )),
                ),
                SizedBox(height: toSize(10)),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Login".toUpperCase(),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Size size;
  const TextFieldContainer({
    Key? key,
    required this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: toSize(10)),
      padding:
          EdgeInsets.symmetric(horizontal: toSize(20), vertical: toSize(8)),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: HexColor("#FBE8F2"),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
