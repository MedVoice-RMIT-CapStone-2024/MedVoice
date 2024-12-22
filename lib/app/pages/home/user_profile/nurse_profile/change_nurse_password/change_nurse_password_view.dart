import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
as clean;
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';

import '../../../../../../common/base_state_view.dart';
import '../../../../../../domain/entities/nurse/nurse_register_request.dart';
import 'change_nurse_password_controller.dart';

const nursePasswordItemRequest = 'nursePasswordItemRequest';
class ChangeNursePasswordView extends clean.View {
  final NurseRegisterRequest nursePasswordItemRequest;

  const ChangeNursePasswordView({Key? key, required this.nursePasswordItemRequest}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangeNursePasswordViewState(nursePasswordItemRequest);
  }
}

class _ChangeNursePasswordViewState
    extends BaseStateView<ChangeNursePasswordView, ChangeNursePasswordController> {
  _ChangeNursePasswordViewState(nursePasswordItemRequest) : super(ChangeNursePasswordController());

  @override
  String appBarTitle() {
    return toText("changeNursePasswordTitle");
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    return const SafeArea(child: SizedBox());
  }
}