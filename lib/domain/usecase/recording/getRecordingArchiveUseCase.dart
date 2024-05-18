import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/recording/recording_archive_info.dart';


class GetRecordingArchiveUseCase extends UseCase<RecordingArchiveInfo, String?> {
  final AudioRepository _audioRepository;

  GetRecordingArchiveUseCase(this._audioRepository);

  @override
  Future<Stream<RecordingArchiveInfo>> buildUseCaseStream(String? params) async {
    final StreamController<RecordingArchiveInfo> controller = StreamController();

    try {
      RecordingArchiveInfo archiveInfo =
      await _audioRepository.getAudioArchive();
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