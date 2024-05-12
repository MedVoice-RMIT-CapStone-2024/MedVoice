import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:med_voice/data/network/http_helper.dart';
import 'package:med_voice/domain/entities/recording/sentences_info.dart';
import 'package:med_voice/domain/entities/recording/upload_recording_request.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../domain/entities/recording/audio_transcript_info.dart';
import '../../domain/entities/recording/audio_transcript_response.dart';
import '../../domain/entities/recording/local_recording_entity/recording_upload_info.dart';
import '../../domain/entities/recording/recording_archive_info.dart';
import '../../domain/entities/recording/recording_archive_response.dart';
import '../../domain/entities/recording/sentences_response.dart';
import '../network/constants.dart';

class AudioRepositoryImpl implements AudioRepository {
  static final AudioRepositoryImpl _instance = AudioRepositoryImpl._internal();

  AudioRepositoryImpl._internal() {}

  factory AudioRepositoryImpl() => _instance;

  @override
  Future<RecordingArchiveInfo> getAudioArchive() async {
    RecordingArchiveInfo recordingArchiveInfo;
    RecordingArchiveResponse recordingArchiveResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.audioArchive), RequestType.get,
          headers: null, body: null);
    } catch (error) {
      debugPrint("Fail to get audio archive list");
      rethrow;
    }

    if (body == null) return RecordingArchiveInfo.buildDefault();
    recordingArchiveResponse = RecordingArchiveResponse.fromJson(body);
    recordingArchiveInfo =
        RecordingArchiveInfo(recordingArchiveResponse.urls ?? [], false);

    return recordingArchiveInfo;
  }

  @override
  Future<bool> uploadAudioFile(RecordingUploadInfo file) async {
    AuthClient? clientResponse;

    String jsonString = await rootBundle.loadString(
        'assets/google_api_auth_key/med-voice-k2d62x-0058f8f06eda.json');
    Map<String, dynamic> credentials = json.decode(jsonString);

    // Authenticate
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(credentials),
      [StorageApi.devstorageReadWriteScope],
    );

    clientResponse = client;
    debugPrint(
        "Load service account credentials succeed: ${clientResponse.credentials.idToken}");

    try {
      final storage = StorageApi(clientResponse);

      String fileName = file.file?.path.split('/').last ?? "";

      await storage.objects.insert(
        Object(name: fileName),
        file.bucketName ?? "",
        uploadMedia: Media(
            file.file?.openRead() ?? Stream<List<int>>.fromIterable([]),
            file.file?.lengthSync() ?? 0),
      );
      clientResponse.close();
    } catch (e) {
      debugPrint('Error uploading file: $e');
      rethrow;
    }
    return true;
  }

  @override
  Future<AudioTranscriptInfo> uploadAudioInfo(
      UploadRecordingRequest request) async {
    AudioTranscriptResponse arrAudioTranscriptResponse;
    AudioTranscriptInfo arrAudioTranscriptInfo;
    Map<String, dynamic>? body;

    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse(Constants.uploadAudioInfo
            .replaceAll("{user_id}", request.userId ?? "")
            .replaceAll("{file_name}", request.fileName ?? "")),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(request.toJson()),
      );
    } catch (error) {
      debugPrint("Invoke HTTP failed: $error");
      rethrow;
    }
    if (body == null) return AudioTranscriptInfo.buildDefault();

    arrAudioTranscriptResponse = AudioTranscriptResponse.fromJson(body);

    List<SentencesInfo> listSentences = [];

    if (arrAudioTranscriptResponse.sentences != null) {
      for (int i = 0; i < arrAudioTranscriptResponse.sentences!.length; i++) {
        SentencesResponse item = arrAudioTranscriptResponse.sentences![i];
        listSentences.add(SentencesInfo(item.speakerTag, item.sentence));
      }
    }

    arrAudioTranscriptInfo = AudioTranscriptInfo(
        arrAudioTranscriptResponse.fileId ??= "", listSentences);

    return arrAudioTranscriptInfo;
  }
}