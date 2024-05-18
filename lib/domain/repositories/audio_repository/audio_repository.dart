import 'package:med_voice/domain/entities/recording/audio_transcript_info.dart';
import 'package:med_voice/domain/entities/recording/upload_recording_request.dart';

import '../../entities/recording/local_recording_entity/recording_upload_info.dart';
import '../../entities/recording/recording_archive_info.dart';

abstract class AudioRepository {
  Future<RecordingArchiveInfo> getAudioArchive();
  Future<bool> uploadAudioFile(RecordingUploadInfo file);
  Future<AudioTranscriptInfo> uploadAudioInfo(UploadRecordingRequest data);
}