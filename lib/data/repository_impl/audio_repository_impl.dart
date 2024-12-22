import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:med_voice/data/network/http_helper.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/current_med_and_drug_aller_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/mental_state_examination_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/physical_examination_info.dart';
import 'package:med_voice/domain/entities/recording/upload_recording_request.dart';
import 'package:med_voice/domain/repositories/audio_repository/audio_repository.dart';

import '../../app/utils/global.dart';
import '../../domain/entities/recording/audio_transcript_info.dart';
import '../../domain/entities/recording/audio_transcript_response.dart';
import '../../domain/entities/recording/library_transcript/demographic_info.dart';
import '../../domain/entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../domain/entities/recording/library_transcript/get_library_transcript_json_response.dart';
import '../../domain/entities/recording/library_transcript/get_library_transcript_request.dart';
import '../../domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import '../../domain/entities/recording/library_transcript/get_library_transcript_text_response.dart';
import '../../domain/entities/recording/library_transcript/library_transcript_info.dart';
import '../../domain/entities/recording/library_transcript/library_transcript_response.dart';
import '../../domain/entities/recording/library_transcript/past_medical_history_info.dart';
import '../../domain/entities/recording/library_transcript/post_transcript_request.dart';
import '../../domain/entities/recording/local_recording_entity/recording_upload_info.dart';
import '../../domain/entities/recording/recording_archive_info.dart';
import '../../domain/entities/recording/recording_archive_response.dart';
import '../network/constants.dart';

class AudioRepositoryImpl implements AudioRepository {
  static final AudioRepositoryImpl _instance = AudioRepositoryImpl._internal();

  AudioRepositoryImpl._internal() {}

  factory AudioRepositoryImpl() => _instance;

  @override
  Future<RecordingArchiveInfo> getAudioArchive(String userId) async {
    RecordingArchiveInfo recordingArchiveInfo;
    RecordingArchiveResponse recordingArchiveResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.audioArchive.replaceAll("{file_id}", userId)),
          RequestType.get,
          headers: null,
          body: null);
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

    String jsonString = await rootBundle
        .loadString('assets/google_api_auth_key/focused-premise-442517-e2-1255c905786b.json');
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
            .replaceAll('{user_id}', Global.userCredentials.id ?? "")
            .replaceAll("{file_id}", request.fileId ?? "")),
        RequestType.post,
        headers: null,
        body: null,
      );
    } catch (error) {
      debugPrint("Invoke HTTP failed: $error");
      rethrow;
    }
    if (body == null) return AudioTranscriptInfo.buildDefault();

    arrAudioTranscriptResponse = AudioTranscriptResponse.fromJson(body);

    arrAudioTranscriptInfo =
        AudioTranscriptInfo(arrAudioTranscriptResponse.fileId ??= "");

    return arrAudioTranscriptInfo;
  }

  @override
  Future<LibraryTranscriptInfo> uploadLibraryTranscript(
      PostTranscriptRequest request) async {
    LibraryTranscriptInfo libraryTranscriptInfo;
    LibraryTranscriptResponse libraryTranscriptResponse;
    Map<String, dynamic>? body;

    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.uploadLibraryTranscript
              .replaceAll('{user_id}', request.fileId ?? "")
              .replaceAll("{file_name}", request.fileName ?? "")),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toJson()));
    } catch (error) {
      debugPrint("Fail to post library transcript $error");
      rethrow;
    }
    if (body == null) return LibraryTranscriptInfo.buildDefault();
    libraryTranscriptResponse = LibraryTranscriptResponse.fromJson(body);
    libraryTranscriptInfo = LibraryTranscriptInfo(
        libraryTranscriptResponse.fileId ?? "",
        libraryTranscriptResponse.transcript ?? "");

    return libraryTranscriptInfo;
  }

  @override
  Future<GetLibraryTranscriptTextInfo> getLibraryTranscriptText(
      GetLibraryTranscriptRequest data) async {
    GetLibraryTranscriptTextInfo info;
    GetLibraryTranscriptTextResponse response;

    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.getLibraryTranscript
              .replaceAll('{file_id}', data.mFileId ?? "")
              .replaceAll('{file_extension}', 'txt')),
          RequestType.get,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get library transcript text");
      rethrow;
    }

    if (body == null) return GetLibraryTranscriptTextInfo.buildDefault();

    response = GetLibraryTranscriptTextResponse.fromJson(body);
    info = GetLibraryTranscriptTextInfo(
        utf8.decode(response.transcript?.runes.toList() ?? []), response.message ?? "");

    return info;
  }

  @override
  Future<GetLibraryTranscriptJsonInfo> getLibraryTranscriptJson(
      GetLibraryTranscriptRequest data) async {
    GetLibraryTranscriptJsonInfo info;
    GetLibraryTranscriptJsonResponse response;

    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.getLibraryTranscript
              .replaceAll('{file_id}', data.mFileId ?? "")
              .replaceAll('{file_extension}', 'json')),
          RequestType.get,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get library transcript text");
      rethrow;
    }

    if (body == null) return GetLibraryTranscriptJsonInfo.buildDefault();

    response = GetLibraryTranscriptJsonResponse.fromJson(body);

    info = GetLibraryTranscriptJsonInfo(
        utf8.decode(response.patientName?.runes.toList() ?? []),
        utf8.decode(response.patientDob?.runes.toList() ?? []),
        utf8.decode(response.patientGender?.runes.toList() ?? []),
        response.patientDemographicResponse != null
            ? DemographicInfo(
            utf8.decode(response.patientDemographicResponse?.maritalStatus?.runes.toList() ?? []),
            utf8.decode(response.patientDemographicResponse?.ethnicity?.runes.toList() ?? []),
            utf8.decode(response.patientDemographicResponse?.occupation?.runes.toList() ?? [])
        )
            : null,
        response.patientPastMedicalHistoryResponse != null
            ? PastMedicalHistoryInfo(
            utf8.decode(response.patientPastMedicalHistoryResponse?.medicalHistory?.runes.toList() ?? []),
            utf8.decode(response.patientPastMedicalHistoryResponse?.surgicalHistory?.runes.toList() ?? [])
        )
            : null,
        response.patientCurrentMedAndDrugAllerResponse != null
            ? CurrentMedAndDrugAllerInfo(
            utf8.decode(response.patientCurrentMedAndDrugAllerResponse?.drugAllergy?.runes.toList() ?? []),
            utf8.decode(response.patientCurrentMedAndDrugAllerResponse?.prescribedMedications?.runes.toList() ?? []),
            utf8.decode(response.patientCurrentMedAndDrugAllerResponse?.recentlyPrescribedMedications?.runes.toList() ?? [])
        )
            : null,
        response.patientMentalStateExaminationResponse != null
            ? MentalStateExaminationInfo(
            utf8.decode(response.patientMentalStateExaminationResponse?.appearanceAndBehaviour?.runes.toList() ?? []),
            utf8.decode(response.patientMentalStateExaminationResponse?.speechAndThoughts?.runes.toList() ?? []),
            utf8.decode(response.patientMentalStateExaminationResponse?.mood?.runes.toList() ?? []),
            utf8.decode(response.patientMentalStateExaminationResponse?.thoughts?.runes.toList() ?? [])
        )
            : null,
        response.patientPhysicalExaminationResponse != null
            ? PhysicalExaminationInfo(
            utf8.decode(response.patientPhysicalExaminationResponse?.bloodPressure?.runes.toList() ?? []),
            utf8.decode(response.patientPhysicalExaminationResponse?.pulseRate?.runes.toList() ?? []),
            utf8.decode(response.patientPhysicalExaminationResponse?.temperature?.runes.toList() ?? [])
        )
            : null,
        utf8.decode(response.note?.runes.toList() ?? []),
        utf8.decode(response.message?.runes.toList() ?? [])
    );

    return info;
  }
}
