import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/onboarding/signup/sign_up_controller.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/module_utils.dart';
import '../../../utils/pages.dart';
import '../components/background_set.dart';
import '../components/small_text_field.dart';
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
    return true;
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
              SizedBox(height: toSize(50)),
              Text("Create new",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: toSize(35),
                    fontWeight: FontWeight.w900,
                  )),
              Text("Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: toSize(35),
                    fontWeight: FontWeight.w900,
                  )),
              SizedBox(height: toSize(10)),
              InkWell(
                onTap: () {
                  pushScreen(Pages.signIn);
                },
                child: Text(
                  "Already registered? Log in here.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: toSize(14),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: toSize(40)),
              SmallTextField(size: size, labelText: "NAME"),
              SmallTextField(size: size, labelText: "EMAIL ADDRESS"),
              SmallTextField(
                size: size,
                labelText: "PASSWORD",
                icon: Icons.lock_outline,
              ),
              SmallTextField(
                size: size,
                labelText: "Date of Birth",
                icon: Icons.calendar_today_outlined,
                hint: "Select",
              ),
              Padding(
                padding: EdgeInsets.all(toSize(20)),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("#EC4B8B"),
                    fixedSize: Size(size.width * 0.7, toSize(50)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: HexColor("#FFFDF5"),
                      fontSize: toSize(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: toSize(150)),
            ],
          ),
        ));
  }
}
