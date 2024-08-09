import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/home/recording/recording/recording_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../utils/global.dart';
import '../../../../widgets/theme_provider.dart';

class RecordingView extends clean.View {
  RecordingView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecordingView();
  }
}

class _RecordingView extends BaseStateView<RecordingView, RecordingController> {
  _RecordingView() : super(RecordingController(AudioRepositoryImpl()));

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
  bool isShowFeedbackFeature() {
    return false;
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
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: toSize(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: toSize(10)),
            Text(
                "Confidence level: ${recordingController!.confidenceLevel * 100}%",
                style: TextStyle(
                  color: theme.colorScheme.onBackground, fontFamily: 'Rubik'
                )),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: toSize(20), vertical: 20),
                child: Container(
                    height: toSize(400),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: toSize(15), vertical: toSize(15)),
                    child: Text(recordingController!.guideText,
                        style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                            fontSize: toSize(18)))),
              ),
            ),
            recordingController!.speechEnabled
              ? _buildTimer(theme)
              : SizedBox(height: toSize(25)),
            Padding(
              padding: EdgeInsets.only(bottom: toSize(110), top: toSize(30)),
              child: AvatarGlow(
                animate: recordingController!.speechEnabled ? true : false,
                glowColor: theme.colorScheme.primary,
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
                            theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                            recordingController!.speechEnabled
                                ? Icons.mic
                                : Icons.mic_off,
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

  Widget _buildTimer(ThemeData theme) {
    if (recordingController == null) return Container();

    final String minutes = recordingController!
        .formatNumber(recordingController!.recordDuration ~/ 60);
    final String seconds = recordingController!
        .formatNumber(recordingController!.recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(
          color: theme.colorScheme.primary,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w700,
          fontSize: toSize(18)),
    );
  }
}
