import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/recording/local_recording_entity/recording_upload_info.dart';

class UploadRecordingUseCase extends UseCase<bool, RecordingUploadInfo?> {
  final AudioRepository _audioRepository;
  UploadRecordingUseCase(this._audioRepository);

  @override
  Future<Stream<bool>> buildUseCaseStream(RecordingUploadInfo? params) async {
    final StreamController<bool> controller =
    StreamController();

    try {
      bool uploadFileResponse = await _audioRepository.uploadAudioFile(params!);
      controller.add(uploadFileResponse);
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