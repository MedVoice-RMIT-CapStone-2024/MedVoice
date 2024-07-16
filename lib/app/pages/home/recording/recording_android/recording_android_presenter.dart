import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/recording/audio_transcript_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/post_transcript_request.dart';
import 'package:med_voice/domain/entities/recording/upload_recording_request.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';
import 'package:med_voice/domain/usecase/recording/uploadAudioInfoUseCase.dart';
import 'package:med_voice/domain/usecase/recording/uploadLibraryTranscriptUseCase.dart';
import 'package:med_voice/domain/usecase/recording/uploadRecordingUseCase.dart';

import '../../../../../domain/entities/recording/library_transcript/library_transcript_info.dart';
import '../../../../../domain/entities/recording/local_recording_entity/recording_upload_info.dart';


class RecordingAndroidPresenter extends Presenter{
  final AudioRepository _audioRepository;
  UploadRecordingUseCase? _uploadRecordingUseCase;
  UploadAudioInfoUseCase? _uploadAudioInfoUseCase;
  UploadLibraryTranscriptUseCase?  _uploadLibraryTranscriptUseCase;

  Function? onUploadRecordingSuccess;
  Function? onUploadRecordingFailed;

  Function? onUploadAudioInfoSuccess;
  Function? onUploadAudioInfoFailed;

  Function? onUploadLibraryTranscriptSuccess;
  Function? onUploadLibraryTranscriptFailed;

  Function? onCompleted;

  RecordingAndroidPresenter(this._audioRepository) {
    _uploadRecordingUseCase = UploadRecordingUseCase(_audioRepository);
    _uploadAudioInfoUseCase = UploadAudioInfoUseCase(_audioRepository);
    _uploadLibraryTranscriptUseCase = UploadLibraryTranscriptUseCase(_audioRepository);
  }

  @override
  void dispose() {
    _uploadRecordingUseCase?.dispose();
    _uploadAudioInfoUseCase?.dispose();
    _uploadLibraryTranscriptUseCase?.dispose();
  }

  void executeUploadRecording(RecordingUploadInfo info) => _uploadRecordingUseCase?.execute(_UploadRecordingUseCaseObserver(this), info);
  void executeUploadAudioInfo(UploadRecordingRequest request) => _uploadAudioInfoUseCase?.execute(_UploadAudioInfoUseCaseObserver(this), request);
  void executeUploadLibraryTranscript(PostTranscriptRequest request) => _uploadLibraryTranscriptUseCase?.execute(_UploadLibraryTranscriptUseCaseObserver(this), request);
}

class _UploadRecordingUseCaseObserver implements Observer<bool> {
  final RecordingAndroidPresenter _presenter;

  _UploadRecordingUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onUploadRecordingFailed != null);
    _presenter.onUploadRecordingFailed!(e);
  }

  @override
  void onNext(bool? response) {
    assert(response is bool);
    _presenter.onUploadRecordingSuccess!(response);
  }
}

class _UploadAudioInfoUseCaseObserver implements Observer<AudioTranscriptInfo> {
  final RecordingAndroidPresenter _presenter;

  _UploadAudioInfoUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onUploadAudioInfoFailed != null);
    _presenter.onUploadAudioInfoFailed!(e);
  }

  @override
  void onNext(AudioTranscriptInfo? response) {
    assert(response is AudioTranscriptInfo);
    _presenter.onUploadAudioInfoSuccess!(response);
  }
}

class _UploadLibraryTranscriptUseCaseObserver implements Observer<LibraryTranscriptInfo> {
  final RecordingAndroidPresenter _presenter;

  _UploadLibraryTranscriptUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onUploadLibraryTranscriptFailed != null);
    _presenter.onUploadLibraryTranscriptFailed!(e);
  }

  @override
  void onNext(LibraryTranscriptInfo? response) {
    assert(response is LibraryTranscriptInfo);
    _presenter.onUploadLibraryTranscriptSuccess!(response);
  }
}