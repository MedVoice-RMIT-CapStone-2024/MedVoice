/// Web stub for the vosk_flutter_2 surface used by `RecordingAndroidController`.
///
/// vosk_flutter_2 is dart:ffi based and cannot be compiled to JS, so pulling it
/// into a web build fails the compile outright. This file mirrors the symbols
/// and signatures the controller and view need so the app builds and loads in a
/// browser; the mobile path keeps using the real plugin via `vosk_io.dart`.
///
/// Model loading throws, which the controller's existing try/catch turns into a
/// visible error message. Upgrade path: back these with the Web Speech API or
/// server-side transcription if browser recognition is ever required.
const String _unsupported = 'Offline recognition is unavailable on web';

/// Stub stand-in for the native vosk model handle.
class Model {}

/// Stub stand-in for the native vosk recognizer handle.
class Recognizer {}

/// Stub loader that always reports web as unsupported.
class ModelLoader {
  Future<String> loadFromAssets(
    String asset, {
    bool forceReload = false,
  }) =>
      throw UnsupportedError(_unsupported);
}

/// Stub plugin. `instance()` stays cheap and non-throwing because the
/// controller creates it in a field initializer; only the async calls throw.
class VoskFlutterPlugin {
  VoskFlutterPlugin._();

  static VoskFlutterPlugin? _instance;

  static VoskFlutterPlugin instance() => _instance ??= VoskFlutterPlugin._();

  Future<Model> createModel(String modelPath) =>
      throw UnsupportedError(_unsupported);

  Future<Recognizer> createRecognizer({
    required Model model,
    required int sampleRate,
    List<String>? grammar,
  }) =>
      throw UnsupportedError(_unsupported);

  Future<SpeechService> initSpeechService(Recognizer recognizer) =>
      throw UnsupportedError(_unsupported);
}

/// Stub speech service. Unreachable on web in practice, since model loading
/// throws first and the view guards on a null service, but the members must
/// exist for the web build to type-check.
class SpeechService {
  Future<bool?> start({Function? onRecognitionError}) async => false;

  Future<bool?> stop() async => false;

  Future<bool?> setPause({required bool paused}) async => false;

  Future<bool?> reset() async => false;

  Future<bool?> cancel() async => false;

  Future<void> dispose() async {}

  Stream<String> onResult() => const Stream<String>.empty();

  Stream<String> onPartial() => const Stream<String>.empty();
}
