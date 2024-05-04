import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:just_audio/just_audio.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/utils/module_utils.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../../domain/entities/recording_archive/recording_info.dart';
import '../../../../utils/global.dart';
import 'audio_playback_controller.dart';

const recordingInfo = 'recordingInfo';

class AudioPlaybackView extends clean.View {
  final RecordingInfo recordingInfo;
  AudioPlaybackView({Key? key, required this.recordingInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AudioPlaybackView(recordingInfo);
  }
}

class _AudioPlaybackView
    extends BaseStateView<AudioPlaybackView, AudioPlaybackController> {
  _AudioPlaybackView(recordingInfo)
      : super(AudioPlaybackController(recordingInfo));

  AudioPlaybackController? audioPlaybackController;

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return widget.recordingInfo.recordingTitle ?? "";
  }

  @override
  void onStateDestroyed() {
    audioPlaybackController?.player.dispose();
    audioPlaybackController?.isPlaying = false;
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    AudioPlaybackController _controller = controller as AudioPlaybackController;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: toSize(300),
                  width: toSize(300),
                  child: Image.asset(ImageAssets.imgMedVoiceLogo)),
              Text("${widget.recordingInfo.path}", textAlign: TextAlign.center),
              SizedBox(height: toSize(58)),
              InkWell(
                onTap: () {
                  if (!_controller.isPlaying) {
                    _controller.player.setAudioSource(
                        AudioSource.file(widget.recordingInfo.path ?? ""));
                    _controller.player.play();
                  } else {
                    if (_controller.player.duration?.inSeconds ==
                        widget.recordingInfo.duration) {
                      _controller.player.stop();
                    } else {
                      _controller.player.pause();
                    }
                  }
                  _controller.isPlaying = !_controller.isPlaying;
                  _controller.refreshUI();
                },
                child: Container(
                  height: toSize(70),
                  width: toSize(70),
                  decoration: BoxDecoration(
                      color: HexColor(Global.mColors['pink_1'].toString()),
                      borderRadius: BorderRadius.circular(20)),
                  child: _controller.isPlaying
                      ? const Icon(
                          Icons.pause,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
