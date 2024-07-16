import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/get_library_transcript_request.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';
import 'package:med_voice/domain/usecase/recording/getLibraryTranscriptJsonUseCase.dart';
import 'package:med_voice/domain/usecase/recording/getLibraryTranscriptTextUseCase.dart';

import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_json_info.dart';


class EnhancedNotePresenter extends Presenter{
  final AudioRepository _audioRepository;
  GetLibraryTranscriptTextUseCase? _getLibraryTranscriptTextUseCase;
  GetLibraryTranscriptJsonUseCase? _getLibraryTranscriptJsonUseCase;

  Function? onGetLibraryTranscriptTextSuccess;
  Function? onGetLibraryTranscriptTextFailed;

  Function? onGetLibraryTranscriptJsonSuccess;
  Function? onGetLibraryTranscriptJsonFailed;

  Function? onCompleted;

  EnhancedNotePresenter(this._audioRepository) {
    _getLibraryTranscriptTextUseCase = GetLibraryTranscriptTextUseCase(_audioRepository);
    _getLibraryTranscriptJsonUseCase = GetLibraryTranscriptJsonUseCase(_audioRepository);
  }

  @override
  void dispose() {
    _getLibraryTranscriptTextUseCase?.dispose();
    _getLibraryTranscriptJsonUseCase?.dispose();
  }

  void executeGetLibraryTranscriptText(GetLibraryTranscriptRequest request) => _getLibraryTranscriptTextUseCase?.execute(_GetLibraryTranscriptTextUseCaseObserver(this), request);
  void executeGetLibraryTranscriptJson(GetLibraryTranscriptRequest request) => _getLibraryTranscriptJsonUseCase?.execute(_GetLibraryTranscriptJsonUseCaseObserver(this), request);

}

class _GetLibraryTranscriptTextUseCaseObserver implements Observer<GetLibraryTranscriptTextInfo> {
  final EnhancedNotePresenter _presenter;

  _GetLibraryTranscriptTextUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onGetLibraryTranscriptTextFailed != null);
    _presenter.onGetLibraryTranscriptTextFailed!(e);
  }

  @override
  void onNext(GetLibraryTranscriptTextInfo? response) {
    assert(response is GetLibraryTranscriptTextInfo);
    _presenter.onGetLibraryTranscriptTextSuccess!(response);
  }
}

class _GetLibraryTranscriptJsonUseCaseObserver implements Observer<GetLibraryTranscriptJsonInfo> {
  final EnhancedNotePresenter _presenter;

  _GetLibraryTranscriptJsonUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onGetLibraryTranscriptJsonFailed != null);
    _presenter.onGetLibraryTranscriptJsonFailed!(e);
  }

  @override
  void onNext(GetLibraryTranscriptJsonInfo? response) {
    assert(response is GetLibraryTranscriptJsonInfo);
    _presenter.onGetLibraryTranscriptJsonSuccess!(response);
  }
}