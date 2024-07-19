import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:lottie/lottie.dart';
import 'package:med_voice/app/pages/onboarding/startup/startup_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../assets/lottie_assets.dart';
import '../../../utils/global.dart';
import '../../../widgets/theme_provider.dart';

class StartupView extends clean.View {
  StartupView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StartupView();
  }
}

class _StartupView extends BaseStateView<StartupView, StartupController>
    with SingleTickerProviderStateMixin {
  _StartupView() : super(StartupController());

  AnimationController? animationController;
  Animation<double>? animation;
  AnimationController? lottieController;
  Timer? lottieTimer;

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  void onStateCreated() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeIn,
    );
    animationController!.forward();

    super.onStateCreated();
  }

  @override
  void onStateDestroyed() {
    lottieController?.dispose();
    animationController?.dispose();
    super.onStateDestroyed();
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme =
        Provider.of<ThemeProvider>(context, listen: false).themeData;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: animation ?? const AlwaysStoppedAnimation(1.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    DecoratedIcon(
                      icon: Icon(Icons.favorite,
                          size: toSize(190),
                          color: (theme.brightness == Brightness.dark)
                              ? HexColor(Global.mColors['pink_2'].toString())
                              : HexColor(Global.mColors['pink_1'].toString())
                                  .withOpacity(0.5)),
                      decoration: IconDecoration(
                          border: IconBorder(
                              color:
                                  HexColor(Global.mColors['pink_1'].toString()),
                              width: 2)),
                    ),
                    Lottie.asset(
                      LottieAssets.imgMedvoiceLogo,
                      frameRate: FrameRate.max,
                      width: toSize(190),
                      height: toSize(220),
                    ),
                  ],
                ),
              ),
              SizedBox(height: toSize(10)),
              Padding(
                padding: EdgeInsets.only(left: toSize(20)),
                child: FadeTransition(
                  opacity: animation ?? const AlwaysStoppedAnimation(1.0),
                  child: AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText('MedVoice',
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(
                            fontSize: toSize(45), fontWeight: FontWeight.w600),
                        textAlign: TextAlign.end)
                  ], isRepeatingAnimation: false),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
