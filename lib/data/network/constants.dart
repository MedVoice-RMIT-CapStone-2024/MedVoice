class Constants {
  static String baseUrl = "";

  static String firstBitUrl = "https://medvoice-be-v5-2-rag.onrender.com/";

  // sample fetch baseball data
  static String baseballList =
      'https://api.sampleapis.com/baseball/hitsSingleSeason';

  // fetching audio
  static String audioArchive = "${firstBitUrl}get_audios_from_user/1";

  // uploading audio info to backend
  static String uploadAudioInfo =
      "${firstBitUrl}process_audio_v2?file_extension=m4a&file_id={file_id}";

  // post transcript text to backend
  static String uploadLibraryTranscript =
      "${firstBitUrl}process_transcript?user_id={user_id}&file_name={file_name}";

  // get library transcript
  static String getLibraryTranscript =
      "${firstBitUrl}get_transcript/{file_id}/{file_extension}";
}

const successStatusCodeList = [200, 201, 204];
