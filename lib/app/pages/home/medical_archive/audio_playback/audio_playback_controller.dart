import 'package:just_audio/just_audio.dart';
import 'package:med_voice/common/base_controller.dart';


class AudioPlaybackController extends BaseController {
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  String recordingInfo;

  AudioPlaybackController(this.recordingInfo);

  @override
  void firstLoad() {
    // TODO: implement firstLoad
  }

  @override
  void onListener() {
    // TODO: implement onListener
  }

  void testFunc() {
  }
}