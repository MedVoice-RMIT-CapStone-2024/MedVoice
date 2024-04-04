import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/onboarding/components/background_set.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/module_utils.dart';
import 'confirm_controller.dart';

class ConfirmView extends View {
  ConfirmView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ConfirmView();
  }
}

class _ConfirmView extends BaseStateView<ConfirmView, ConfirmController> {
  _ConfirmView() : super(ConfirmController());
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
    ConfirmController _controller = controller as ConfirmController;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: HexColor("#FBE8F2"),
        body: BackgroundSetUp(
          link: 'assets/images/bg5.png',
          isShowLogo: false,
          isSignUpView: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/email.png',
                  width: toSize(190), height: toSize(190), fit: BoxFit.fill),
              Text("Check your Inbox",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: toSize(30),
                    fontWeight: FontWeight.w800,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: Text(
                  "An email containing instructions to reset your password has been sent to @dudu.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: toSize(13),
                    fontWeight: FontWeight.w300,
                  ),
                ),
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
                    "Open email app",
                    style: TextStyle(
                      color: HexColor("#FFFDF5"),
                      fontSize: toSize(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: toSize(10)),
              Text("Resend email",
                  style: TextStyle(
                    color: HexColor("#EC4B8B"),
                    fontSize: toSize(14),
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ));
  }
}
