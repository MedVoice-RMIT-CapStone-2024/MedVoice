import 'package:med_voice/domain/entities/recording/audio_transcript_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/post_transcript_request.dart';
import 'package:med_voice/domain/entities/recording/upload_recording_request.dart';

import '../../entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../entities/recording/library_transcript/get_library_transcript_request.dart';
import '../../entities/recording/library_transcript/library_transcript_info.dart';
import '../../entities/recording/local_recording_entity/recording_upload_info.dart';
import '../../entities/recording/recording_archive_info.dart';

abstract class AudioRepository {
  Future<RecordingArchiveInfo> getAudioArchive();
  Future<bool> uploadAudioFile(RecordingUploadInfo file);
  Future<AudioTranscriptInfo> uploadAudioInfo(UploadRecordingRequest data);
  Future<LibraryTranscriptInfo> uploadLibraryTranscript(PostTranscriptRequest data);
  Future<GetLibraryTranscriptTextInfo> getLibraryTranscriptText(GetLibraryTranscriptRequest data);
  Future<GetLibraryTranscriptJsonInfo> getLibraryTranscriptJson(GetLibraryTranscriptRequest data);
}