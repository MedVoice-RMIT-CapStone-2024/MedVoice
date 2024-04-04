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
import '../components/small_text_field.dart';
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
          isShowLogo: true,
          isSignUpView: false,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                SizedBox(height: toSize(5)),
                SmallTextField(
                  size: size,
                  labelText: "EMAIL ADDRESS",
                  hint: "Jiara Martins",
                ),
                SmallTextField(
                  size: size,
                  labelText: "PASSWORD",
                  hint: "********",
                ),
                Padding(
                  padding: EdgeInsets.all(toSize(10)),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(size.width * 0.6, toSize(50)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: HexColor("#FFFDF5"),
                        fontSize: toSize(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: toSize(30)),
                InkWell(
                  onTap: () {
                    pushScreen(Pages.reset);
                  },
                  child: Text("Forgot password?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: toSize(15),
                        fontWeight: FontWeight.w300,
                      )),
                ),
                SizedBox(height: toSize(20)),

                InkWell(
                  onTap: () {
                    pushScreen(Pages.signUp);
                  },
                  child: Text("Signup !",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: toSize(14),
                        fontWeight: FontWeight.w300,
                      )),
                ),
              ]),
        ));
  }
}
