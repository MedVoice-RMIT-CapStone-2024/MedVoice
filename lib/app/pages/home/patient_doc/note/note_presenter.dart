import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/get_library_transcript_request.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';
import 'package:med_voice/domain/usecase/recording/getLibraryTranscriptJsonUseCase.dart';
import 'package:med_voice/domain/usecase/recording/getLibraryTranscriptTextUseCase.dart';
import 'package:med_voice/domain/usecase/recording/uploadAudioInfoUseCase.dart';

import '../../../../../domain/entities/recording/audio_transcript_info.dart';
import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../../../../domain/entities/recording/upload_recording_request.dart';


class NotePresenter extends Presenter{
  final AudioRepository _audioRepository;
  GetLibraryTranscriptTextUseCase? _getLibraryTranscriptTextUseCase;
  GetLibraryTranscriptJsonUseCase? _getLibraryTranscriptJsonUseCase;
  UploadAudioInfoUseCase? _uploadAudioInfoUseCase;

  Function? onGetLibraryTranscriptTextSuccess;
  Function? onGetLibraryTranscriptTextFailed;

  Function? onGetLibraryTranscriptJsonSuccess;
  Function? onGetLibraryTranscriptJsonFailed;

  Function? onUploadAudioInfoSuccess;
  Function? onUploadAudioInfoFailed;

  Function? onCompleted;

  NotePresenter(this._audioRepository) {
    _getLibraryTranscriptTextUseCase = GetLibraryTranscriptTextUseCase(_audioRepository);
    _getLibraryTranscriptJsonUseCase = GetLibraryTranscriptJsonUseCase(_audioRepository);
    _uploadAudioInfoUseCase = UploadAudioInfoUseCase(_audioRepository);
  }

  @override
  void dispose() {
    _getLibraryTranscriptTextUseCase?.dispose();
    _getLibraryTranscriptJsonUseCase?.dispose();
    _uploadAudioInfoUseCase?.dispose();
  }

  void executeGetLibraryTranscriptText(GetLibraryTranscriptRequest request) => _getLibraryTranscriptTextUseCase?.execute(_GetLibraryTranscriptTextUseCaseObserver(this), request);
  void executeGetLibraryTranscriptJson(GetLibraryTranscriptRequest request) => _getLibraryTranscriptJsonUseCase?.execute(_GetLibraryTranscriptJsonUseCaseObserver(this), request);
  void executeUploadAudioInfo(UploadRecordingRequest request) => _uploadAudioInfoUseCase?.execute(_UploadAudioInfoUseCaseObserver(this), request);

}

class _GetLibraryTranscriptTextUseCaseObserver implements Observer<GetLibraryTranscriptTextInfo> {
  final NotePresenter _presenter;

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
  final NotePresenter _presenter;

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

class _UploadAudioInfoUseCaseObserver implements Observer<AudioTranscriptInfo> {
  final NotePresenter _presenter;

  _UploadAudioInfoUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onUploadAudioInfoFailed != null);
    _presenter.onGetLibraryTranscriptTextFailed!(e);
  }

  @override
  void onNext(AudioTranscriptInfo? response) {
    assert(response is AudioTranscriptInfo);
    _presenter.onUploadAudioInfoSuccess!(response);
  }
}