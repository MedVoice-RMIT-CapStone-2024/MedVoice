import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/home/recording_documentation/recording/recording_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart'; // Import SystemAppTheme
import 'package:med_voice/app/widgets/theme.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../utils/global.dart';
import 'package:avatar_glow/avatar_glow.dart';

class RecordingView extends clean.View {
  RecordingView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecordingViewState();
  }
}

class _RecordingViewState
    extends BaseStateView<RecordingView, RecordingController> {
  _RecordingViewState() : super(RecordingController());

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

    // Get the current theme mode
    ThemeMode currentThemeMode =
        SystemAppTheme.systemThemeNotifier.currentTheme();

    // Determine the background color based on theme mode
    Color backgroundColor = currentThemeMode == ThemeMode.dark
        ? Colors.black.withOpacity(0.1)
        : Colors.pink.withOpacity(0.1);

    return Scaffold(
      backgroundColor: Colors.pink,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: toSize(10)),
              Text(
                  "Confidence level: ${recordingController!.confidenceLevel * 100}%"),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: toSize(20), vertical: 50),
                  child: Container(
                    height: toSize(400),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: backgroundColor, // Use determined background color
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: toSize(15), vertical: toSize(15)),
                    child: Text(recordingController!.guideText),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                color: HexColor(Global.mColors['pink_1'].toString()),
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
                        color: HexColor(Global.mColors['pink_1'].toString()),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        !recordingController!.speechEnabled
                            ? Icons.mic_off
                            : Icons.mic,
                        size: toSize(35),
                        color: HexColor(Global.mColors['white_2'].toString()),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          fontSize: toSize(18),
        ),
      ),
    );
  }
}
