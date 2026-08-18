import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entities/recording/recording_list.dart';
import '../../../../domain/repositories/audio_repository/audio_repository.dart';

class MedicalArchivePresenter extends Presenter {
  final AudioRepository _audioRepository;

  Function? onLoadRecordingsSucceed;
  Function? onLoadRecordingsFailed;

  MedicalArchivePresenter(this._audioRepository);

  @override
  void dispose() {}

  Future<void> executeListRecordings() async {
    try {
      final RecordingList list = await _audioRepository.listRecordings();
      onLoadRecordingsSucceed?.call(list);
    } catch (e) {
      onLoadRecordingsFailed?.call(e);
    }
  }
}
