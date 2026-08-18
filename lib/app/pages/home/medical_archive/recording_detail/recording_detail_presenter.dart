import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../domain/entities/recording/recording_detail.dart';
import '../../../../../domain/repositories/audio_repository/audio_repository.dart';

class RecordingDetailPresenter extends Presenter {
  final AudioRepository _audioRepository;

  Function? onLoadDetailSucceed;
  Function? onLoadDetailFailed;
  Function? onDeleteSucceed;
  Function? onDeleteFailed;

  RecordingDetailPresenter(this._audioRepository);

  @override
  void dispose() {}

  Future<void> executeGetRecordingDetail(String recordingId) async {
    try {
      final RecordingDetail detail =
          await _audioRepository.getRecordingDetail(recordingId);
      onLoadDetailSucceed?.call(detail);
    } catch (e) {
      onLoadDetailFailed?.call(e);
    }
  }

  Future<void> executeDeleteRecording(String recordingId) async {
    try {
      await _audioRepository.deleteRecording(recordingId);
      onDeleteSucceed?.call();
    } catch (e) {
      onDeleteFailed?.call(e);
    }
  }
}
