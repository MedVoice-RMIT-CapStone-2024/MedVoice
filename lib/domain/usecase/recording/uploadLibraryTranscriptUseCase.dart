import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/recording/library_transcript/library_transcript_info.dart';
import '../../entities/recording/library_transcript/post_transcript_request.dart';


class UploadLibraryTranscriptUseCase extends UseCase<LibraryTranscriptInfo, PostTranscriptRequest?> {
  final AudioRepository _audioRepository;

  UploadLibraryTranscriptUseCase(this._audioRepository);

  @override
  Future<Stream<LibraryTranscriptInfo>> buildUseCaseStream(PostTranscriptRequest? params) async {
    final StreamController<LibraryTranscriptInfo> controller = StreamController();

    try {
      LibraryTranscriptInfo archiveInfo = await _audioRepository.uploadLibraryTranscript(params!);
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