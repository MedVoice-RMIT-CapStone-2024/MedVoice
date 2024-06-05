import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../entities/recording/library_transcript/get_library_transcript_request.dart';


class GetLibraryTranscriptJsonUseCase extends UseCase<GetLibraryTranscriptJsonInfo, GetLibraryTranscriptRequest> {
  final AudioRepository _audioRepository;

  GetLibraryTranscriptJsonUseCase(this._audioRepository);

  @override
  Future<Stream<GetLibraryTranscriptJsonInfo>> buildUseCaseStream(GetLibraryTranscriptRequest? params) async {
    final StreamController<GetLibraryTranscriptJsonInfo> controller = StreamController();

    try {
      GetLibraryTranscriptJsonInfo transcriptJsonInfo = await _audioRepository.getLibraryTranscriptJson(params!);
      controller.add(transcriptJsonInfo);
      debugPrint('get transcript JSON info successful.');
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