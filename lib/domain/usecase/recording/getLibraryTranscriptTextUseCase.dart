import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/recording/library_transcript/get_library_transcript_request.dart';
import '../../entities/recording/library_transcript/get_library_transcript_text_info.dart';


class GetLibraryTranscriptTextUseCase extends UseCase<GetLibraryTranscriptTextInfo, GetLibraryTranscriptRequest> {
  final AudioRepository _audioRepository;

  GetLibraryTranscriptTextUseCase(this._audioRepository);

  @override
  Future<Stream<GetLibraryTranscriptTextInfo>> buildUseCaseStream(GetLibraryTranscriptRequest? params) async {
    final StreamController<GetLibraryTranscriptTextInfo> controller = StreamController();

    try {
      GetLibraryTranscriptTextInfo transcriptTextInfo = await _audioRepository.getLibraryTranscriptText(params!);
      controller.add(transcriptTextInfo);
      debugPrint('get transcript text info successful.');
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