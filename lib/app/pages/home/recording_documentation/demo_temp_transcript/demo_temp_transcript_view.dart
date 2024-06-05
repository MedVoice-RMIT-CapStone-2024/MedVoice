import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/recording_documentation/demo_temp_transcript/demo_temp_transcript_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/domain/entities/recording/audio_transcript_info.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';

const audioTranscriptInfo = 'audioTranscriptInfo';

class DemoTempTranscriptView extends clean.View {
  final AudioTranscriptInfo audioTranscriptInfo;
  const DemoTempTranscriptView({Key? key, required this.audioTranscriptInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DemoTempTranscriptView(audioTranscriptInfo);
  }
}

class _DemoTempTranscriptView extends BaseStateView<DemoTempTranscriptView, DemoTempTranscriptController> {
  _DemoTempTranscriptView(audioTranscriptInfo) : super(DemoTempTranscriptController(audioTranscriptInfo));

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "ID: ${widget.audioTranscriptInfo.mFileId}";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    DemoTempTranscriptController _controller = controller as DemoTempTranscriptController;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(toSize(20), toSize(20), toSize(20), 0),
          child: Container(
            width: double.infinity,
            height: toSize(500),
            padding: EdgeInsets.all(toSize(20)),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(toSize(10))),
            child: Text(
              _controller.transcript,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
