import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/recording/audio_transcript_info.dart';
import 'package:med_voice/domain/entities/recording/upload_recording_request.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';


class UploadAudioInfoUseCase extends UseCase<AudioTranscriptInfo, UploadRecordingRequest?> {
  final AudioRepository _audioRepository;

  UploadAudioInfoUseCase(this._audioRepository);

  @override
  Future<Stream<AudioTranscriptInfo>> buildUseCaseStream(UploadRecordingRequest? params) async {
    final StreamController<AudioTranscriptInfo> controller = StreamController();

    try {
      AudioTranscriptInfo archiveInfo = await _audioRepository.uploadAudioInfo(params!);
      controller.add(archiveInfo);
      debugPrint('get archive info successful.');
      controller.close();
    } catch (e) {
      if (e is APIException) {
        debugPrint("failed ${e.message}");
        controller.addError(e.message);
      } else {
        debugPrint("failed $e");
        controller.addError("");
      }
    }
    return controller.stream;
  }
}