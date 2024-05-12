import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../../../domain/entities/recording/recording_archive_info.dart';
import '../../../../domain/usecase/recording/getRecordingArchiveUseCase.dart';

class MedicalArchivePresenter extends Presenter {
  final AudioRepository _audioRepository;
  GetRecordingArchiveUseCase? _getRecordingArchiveUseCase;

  Function? onLoadRecordingArchiveSucceed;
  Function? onLoadRecordingArchiveFailed;

  Function? onCompleted;

  MedicalArchivePresenter(this._audioRepository) {
    _getRecordingArchiveUseCase =
        GetRecordingArchiveUseCase(_audioRepository);
  }

  @override
  void dispose() {
    _getRecordingArchiveUseCase?.dispose();
  }

  void executeGetRecordingArchive() => _getRecordingArchiveUseCase?.execute(
      _GetRecordingArchiveUseCaseObserver(this), null);
}

class _GetRecordingArchiveUseCaseObserver
    implements Observer<RecordingArchiveInfo> {
  final MedicalArchivePresenter _presenter;
  _GetRecordingArchiveUseCaseObserver(this._presenter);

  @override
  void onNext(RecordingArchiveInfo? response) {
    assert(response is RecordingArchiveInfo);
    _presenter.onLoadRecordingArchiveSucceed!(response);
  }

  @override
  void onError(e) {
    assert(_presenter.onLoadRecordingArchiveFailed != null);
    _presenter.onLoadRecordingArchiveFailed!(e);
  }

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }
}