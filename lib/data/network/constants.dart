class Constants {
  static String baseUrl = "http://localhost:8000/";

  // Recordings API (medvoice-service contract v1)
  static String get recordings => "${baseUrl}recordings";
  static String recordingDetail(String id) => "${baseUrl}recordings/$id";
}
