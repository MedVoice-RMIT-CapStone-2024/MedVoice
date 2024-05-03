import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/pages/onboarding/startup/startup_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';

class StartupView extends clean.View {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: toSize(300),
                  width: toSize(300),
                  child: Image.asset(ImageAssets.imgMedVoiceLogo)),
              SizedBox(height: toSize(100)),
            ],
          ),
        ),
      ),
    );
  }
}
