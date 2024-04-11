import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../common/base_controller.dart';
import '../../../common/base_state_view.dart';
import 'nurse_profile_controller.dart';

class NurseProfileView extends View {
  NurseProfileView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _NurseProfileView();
  }
}

class _NurseProfileView
    extends BaseStateView<NurseProfileView, NurseProfileController> {
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
    return Container();
  }
}
