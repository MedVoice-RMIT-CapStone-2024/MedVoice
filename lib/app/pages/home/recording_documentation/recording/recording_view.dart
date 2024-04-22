import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/home/recording_documentation/recording/recording_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
            Text(
                "Confidence level: ${recordingController!.confidenceLevel * 100}%"),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: toSize(20), vertical: 50),
                child: Container(
                    height: toSize(200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.1)),
                    padding: EdgeInsets.symmetric(
                        horizontal: toSize(15), vertical: toSize(15)),
                    child: Text(recordingController!.guideText)),
              ),
            ),
            const Spacer(),
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
                      if (recordingController!.isNotListening) {
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
                            recordingController!.isNotListening
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

// class RecordingView extends StatefulWidget {
//   const RecordingView({Key? key}) : super(key: key);

//   @override
//   RecordingViewState createState() => RecordingViewState();
// }

// class RecordingViewState extends State<RecordingView> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   bool _speechAvailable = false;
//   String _lastWords = '';
//   String _currentWords = '';
//   final String _selectedLocaleId = 'es_MX';

//   printLocales() async {
//     var locales = await _speechToText.locales();
//     for (var local in locales) {
//       debugPrint(local.name);
//       debugPrint(local.localeId);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   void errorListener(SpeechRecognitionError error) {
//     debugPrint(error.errorMsg.toString());
//   }

//   void statusListener(String status) async {
//     debugPrint("status $status");
//     if (status == "done" && _speechEnabled) {
//       setState(() {
//         _lastWords += " $_currentWords";
//         _currentWords = "";
//         _speechEnabled = false;
//       });
//       await _startListening();
//     }
//   }

//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechAvailable = await _speechToText.initialize(
//         onError: errorListener, onStatus: statusListener);
//     setState(() {});
//   }

//   /// Each time to start a speech recognition session
//   Future _startListening() async {
//     debugPrint("=================================================");
//     await _stopListening();
//     await Future.delayed(const Duration(milliseconds: 50));
//     await _speechToText.listen(
//         onResult: _onSpeechResult,
//         localeId: _selectedLocaleId,
//         cancelOnError: false,
//         partialResults: true,
//         listenMode: ListenMode.dictation);
//     setState(() {
//       _speechEnabled = true;
//     });
//   }

//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   Future _stopListening() async {
//     setState(() {
//       _speechEnabled = false;
//     });
//     await _speechToText.stop();
//   }

//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _currentWords = result.recognizedWords;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Speech Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: const Text(
//                 'Recognized words:',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 _lastWords.isNotEmpty
//                     ? '$_lastWords $_currentWords'
//                     : _speechAvailable
//                         ? 'Tap the microphone to start listening...'
//                         : 'Speech not available',
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(50.0),
//         child: FloatingActionButton(
//           onPressed:
//               _speechToText.isNotListening ? _startListening : _stopListening,
//           tooltip: 'Listen',
//           child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//         ),
//       ),
//     );
//   }
// }
