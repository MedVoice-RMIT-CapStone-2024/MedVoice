import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean;
import 'package:hexcolor/hexcolor.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/global.dart';
import '../../../utils/module_utils.dart';
import '../../../utils/pages.dart';
import '../signup/sign_up_view.dart';
import 'onboarding_welcome_controller.dart';

class OnBoardingWelcomeView extends clean.View {
  OnBoardingWelcomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingWelcomeView();
  }
}

class _OnBoardingWelcomeView
    extends BaseStateView<OnBoardingWelcomeView, OnBoardingWelcomeController> {
  _OnBoardingWelcomeView() : super(OnBoardingWelcomeController());

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
    OnBoardingWelcomeController _controller =
        controller as OnBoardingWelcomeController;
    return Scaffold(
      backgroundColor: HexColor(Global.mColors['white_2'].toString()),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(43)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  _controller.onBoardingWelcomeImage[_controller.currentStep],
                  height: toSize(200),
                  width: toSize(200),
                  key: ValueKey<int>(_controller.currentStep),
                ),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.001),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
              ),
              SizedBox(height: toSize(30)),
              Text("MedVoice", style: TextStyle(fontSize: toSize(34))),
              SizedBox(height: toSize(16)),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _controller.onBoardingWelcomeMessage[_controller.currentStep],
                  key: ValueKey<int>(_controller.currentStep),
                  style: TextStyle(fontSize: toSize(20)),
                  textAlign: TextAlign.center,
                ),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.01),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
              ),
              SizedBox(height: toSize(70)),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Image.asset(
                  _controller.onBoardingProgressIndicatorImage[
                      _controller.currentStep],
                  height: toSize(40),
                  width: toSize(104),
                  key: ValueKey<int>(_controller.currentStep),
                ),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.001),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: toSize(20)),
        child: SizedBox(
          height: toSize(150),
          width: toSize(319),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  pushScreen(Pages.signUp,
                      arguments: {isFromOnBoardingParam: true});
                },
                child: Container(
                  height: toSize(64),
                  width: toSize(319),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor(Global.mColors['pink_1'].toString())),
                  child: Center(
                      child: Text("Get Started",
                          style: TextStyle(
                              fontSize: toSize(20),
                              color: HexColor(
                                  Global.mColors['white_2'].toString())))),
                ),
              ),
              SizedBox(height: toSize(20)),
              InkWell(
                onTap: () {
                  pushScreen(Pages.signIn, isAllowBack: false);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                            fontSize: toSize(17),
                            color:
                                HexColor(Global.mColors['black_2'].toString())),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                            fontSize: toSize(17),
                            color:
                                HexColor(Global.mColors['pink_1'].toString()),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: toSize(40))
            ],
          ),
        ),
      ),
    );
  }
}
