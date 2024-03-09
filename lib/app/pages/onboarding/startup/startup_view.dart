import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/onboarding/startup/startup_controller.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/global.dart';

class StartupView extends View {
  StartupView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StartupView();
  }
}

class _StartupView extends BaseStateView<StartupView, StartupController> {
  _StartupView() : super(StartupController());

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
    StartupController startupController = controller as StartupController;
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Hi, welcome to MedCare")),
    );
  }
}
