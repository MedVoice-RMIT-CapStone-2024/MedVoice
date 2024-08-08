class Constants {
  static String baseUrl = "http://localhost:8000/";

  static String firstBitUrl = "https://medvoice-fastapi.ngrok.dev/";

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

  static String askEndpoint = "${firstBitUrl}test/llm/ask-llama2";
}

const successStatusCodeList = [200, 201, 204];
