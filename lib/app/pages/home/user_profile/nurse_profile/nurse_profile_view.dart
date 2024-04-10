import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean;

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../utils/module_utils.dart';
import '../../../../utils/pages.dart';
import 'nurse_profile_controller.dart';

class NurseProfileView extends clean.View {
  NurseProfileView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NurseProfileView();
  }
}

class _NurseProfileView extends BaseStateView<NurseProfileView, NurseProfileController> {
  _NurseProfileView() : super(NurseProfileController());

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
    NurseProfileController _controller = controller as NurseProfileController;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Nurse profile view"),
              SizedBox(height: toSize(20)),
              InkWell(
                onTap: (){
                  pushScreen(Pages.signIn, isAllowBack: false);
                },
                child: const Text("Sign out", style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        )
      ),
    );
  }
}
