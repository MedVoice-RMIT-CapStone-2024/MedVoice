import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/home/recording_documentation/recording/recording_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../utils/global.dart';

class RecordingView extends clean.View {
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
  void onStateDestroyed() {
    recordingController?.recordSub?.cancel();
    recordingController?.amplitudeSub?.cancel();
    recordingController?.audioRecorder.dispose();
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
                padding:
                    EdgeInsets.symmetric(horizontal: toSize(20), vertical: 20),
                child: Container(
                    height: toSize(400),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.1)),
                    padding: EdgeInsets.symmetric(
                        horizontal: toSize(15), vertical: toSize(15)),
                    child: Text(recordingController!.guideText)),
              ),
            ),
            recordingController!.speechEnabled
              ? _buildTimer()
              : SizedBox(height: toSize(25)),
            Padding(
              padding: EdgeInsets.only(bottom: toSize(110), top: toSize(30)),
              child: AvatarGlow(
                animate: true,
                glowColor: HexColor(Global.mColors['pink_1'].toString()),
                glowRadiusFactor: 0.3,
                duration: const Duration(milliseconds: 1700),
                repeat: true,
                child: InkWell(
                    onTap: () {
                      if (!recordingController!.speechEnabled) {
                        recordingController!.startListening();
                      } else {
                        recordingController!.stopListening();
                      }
                    },
                    child: Container(
                        height: toSize(80),
                        width: toSize(80),
                        decoration: BoxDecoration(
                            color:
                                HexColor(Global.mColors['pink_1'].toString()),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                            recordingController!.speechEnabled
                                ? Icons.mic_off
                                : Icons.mic,
                            size: toSize(35),
                            color: HexColor(
                                Global.mColors['white_2'].toString())))),
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

    return Text(
      '$minutes : $seconds',
      style: TextStyle(
          color: HexColor(Global.mColors["pink_1"].toString()),
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w700,
          fontSize: toSize(18)),
    );
  }
}