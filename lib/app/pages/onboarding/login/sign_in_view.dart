import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/onboarding/login/sign_in_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/pages.dart';
import '../components/background_set.dart';
import '../components/text_field_container.dart';

class SignInView extends View {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignInView();
  }
}

class _SignInView extends BaseStateView<SignInView, SignInController> {
  _SignInView() : super(SignInController());

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
    SignInController _controller = controller as SignInController;
    // const double defaultPadding = 16.0;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: HexColor("#FBE8F2"),
        body: BackgroundSetUp(
          link: 'assets/images/bg2.png',
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

                Padding(
                  padding: EdgeInsets.all(toSize(20)),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(size.width * 0.6, toSize(70)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: toSize(20),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: toSize(30)),

                Text("Forgot password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: toSize(15),
                      fontWeight: FontWeight.w300,
                    )),
                SizedBox(height: toSize(15)),

                InkWell(
                  onTap: () {
                    pushScreen(Pages.signUp);
                  },
                  child: Text("Don't have an account? Sign up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: toSize(15),
                        fontWeight: FontWeight.w400,
                      )),
                ),

                SizedBox(height: toSize(40)),
              ]),
        ));
  }
}
