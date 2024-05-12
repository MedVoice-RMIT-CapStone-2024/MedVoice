class Constants {
  static String baseUrl = "";

  static String firstBitUrl = "https://81dd-14-191-64-80.ngrok-free.app/";

  // sample fetch baseball data
  static String baseballList = 'https://api.sampleapis.com/baseball/hitsSingleSeason';

  // fetching audio
  static String audioArchive = "${firstBitUrl}get_audio/1";

  // uploading audio info to backend
  static String uploadAudioInfo = "${firstBitUrl}process_audio?user_id={user_id}&file_name={file_name}";
}

const successStatusCodeList = [200, 201, 204];