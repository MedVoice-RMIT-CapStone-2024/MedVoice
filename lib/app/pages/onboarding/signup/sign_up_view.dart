import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/onboarding/signup/sign_up_controller.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../assets/icon_assets.dart';
import '../../../assets/image_assets.dart';
import '../../../utils/global.dart';
import '../../../utils/module_utils.dart';
import '../../../utils/pages.dart';
import '../../../widgets/background_set.dart';
import '../../../widgets/small_text_field.dart';

const isFromOnBoardingParam = "isFromOnBoardingParam";
class SignUpView extends View {

  final bool isFromOnBoarding;

  SignUpView({Key? key,
  required this.isFromOnBoarding}) : super(key: key);

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
        backgroundColor: HexColor(Global.mColors['pink_2'].toString()),
        body: BackgroundSetUp(
          link: ImageAssets.imgBg3,
          isShowLogo: false,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: toSize(20)),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: toSize(90)),
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
                              if (widget.isFromOnBoarding){
                                pushScreen(Pages.signIn);
                              } else {
                                onBack();
                              }
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
                                fixedSize: Size(size.width * 0.75, toSize(50)),
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
                          SizedBox(height: toSize(60))
                        ],
                      ),
                      Positioned(
                        top: toSize(60),
                        child: InkWell(
                          onTap: () {
                            onBack();
                          },
                          child: Image.asset(
                            IconAssets.icBack,
                            width: toSize(20),
                            height: toSize(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
