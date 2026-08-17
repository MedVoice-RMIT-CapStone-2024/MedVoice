/// Real vosk surface, used on Android/iOS.
///
/// vosk_flutter_2 is dart:ffi based, so it cannot be compiled to JS. Web builds
/// get `vosk_web.dart` instead via the conditional import in
/// `recording_android_controller.dart`.
export 'package:vosk_flutter_2/vosk_flutter_2.dart'
    show Model, ModelLoader, Recognizer, SpeechService, VoskFlutterPlugin;
