import 'package:flutter_test/flutter_test.dart';
import 'package:med_voice/app/pages/home/recording/recording_android/vosk_web.dart';

void main() {
  test('instance() does not throw so the controller can build its field', () {
    // RecordingAndroidController creates the plugin in a field initializer, so a
    // throwing instance() would crash the recording page on web instead of
    // showing an error message.
    expect(VoskFlutterPlugin.instance(), isA<VoskFlutterPlugin>());
  });

  test('model loading throws UnsupportedError for the controller to catch', () {
    expect(
      () => ModelLoader().loadFromAssets('assets/vosk_model/any.zip'),
      throwsUnsupportedError,
    );
    expect(
      () => VoskFlutterPlugin.instance().createModel('/any/path'),
      throwsUnsupportedError,
    );
  });

  test('speech service streams are empty rather than absent', () async {
    final service = SpeechService();
    expect(await service.onPartial().toList(), isEmpty);
    expect(await service.onResult().toList(), isEmpty);
    expect(await service.stop(), isFalse);
  });
}
