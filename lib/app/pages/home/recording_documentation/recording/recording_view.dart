import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/home/recording_documentation/recording/recording_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../utils/global.dart';

class RecordingView extends View {
  RecordingView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecordingView();
  }
}

class _RecordingView extends BaseStateView<RecordingView, RecordingController> {
  _RecordingView() : super(RecordingController());

  RecordingController? recordingController;

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "Recorder";
  }

  @override
  bool isHideBackButton() {
    return true;
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    recordingController = controller as RecordingController;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: toSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: toSize(10)),
                Text("Confidence level: ${recordingController!.confidenceLevel * 100}%"),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: toSize(20), vertical: 50),
                    child: SizedBox(
                      height: toSize(400),
                      width: double.infinity,
                      child: Text(recordingController!.guideText)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: toSize(110)),
                  child: AvatarGlow(
                    animate: true,
                    glowColor: HexColor(Global.mColors['pink_1'].toString()),
                    glowRadiusFactor: 0.3,
                    duration: const Duration(milliseconds: 1700),
                    repeat: true,
                    child: InkWell(
                        onTap: () {
                          recordingController!.startListening();
                        },
                        child: Container(
                            height: toSize(80),
                            width: toSize(80),
                            decoration: BoxDecoration(
                                color: HexColor(Global.mColors['pink_1'].toString()),
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                                recordingController!.isListening ? Icons.mic : Icons.mic_none,
                                size: toSize(35),
                                color: HexColor(Global.mColors['white_2'].toString())))),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildTimer() {
    if (recordingController == null) return Container();

    final String minutes = recordingController!
        .formatNumber(recordingController!.recordDuration ~/ 60);
    final String seconds = recordingController!
        .formatNumber(recordingController!.recordDuration % 60);

    return Padding(
        padding: EdgeInsets.only(left: toSize(10)),
        child: Text(
          '$minutes : $seconds',
          style: TextStyle(
              color: HexColor(Global.mColors["red_2"].toString()),
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w700,
              fontSize: toSize(18)),
        ));
  }
}
