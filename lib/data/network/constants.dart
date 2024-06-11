class Constants {
  static String baseUrl = "";

  static String firstBitUrl = "https://medvoice-fastapi.ngrok.dev/";

  // sample fetch baseball data
  static String baseballList = 'https://api.sampleapis.com/baseball/hitsSingleSeason';

  // fetching audio
  static String audioArchive = "${firstBitUrl}get_audios_from_user/1";

  // uploading audio info to backend
  static String uploadAudioInfo = "${firstBitUrl}process_audio_v2?user_id={user_id}&file_name={file_name}";

  // post transcript text to backend
  static String uploadLibraryTranscript = "${firstBitUrl}process_transcript?file_id={file_id}";

  // get library transcript
  static String getLibraryTranscript = "${firstBitUrl}get_transcript/{file_id}/{file_extension}";
}

const successStatusCodeList = [200, 201, 204];