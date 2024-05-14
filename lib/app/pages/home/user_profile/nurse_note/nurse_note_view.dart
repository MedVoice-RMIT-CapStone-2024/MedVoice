import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/user_profile/nurse_note/nurse_note_controller.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

class NurseNoteView extends clean.View {
  NurseNoteView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _NurseNoteView();
  }
}

class _NurseNoteView extends BaseStateView<NurseNoteView, NurseNoteController> {
  _NurseNoteView() : super(NurseNoteController());
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
    NurseNoteController _controller = controller as NurseNoteController;
    return Container();
  }
}
