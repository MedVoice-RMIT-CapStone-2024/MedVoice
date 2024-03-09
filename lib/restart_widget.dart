import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
/**
    flutter run -t lib/main_dev.dart  --flavor=dev --no-sound-null-safety
    # Debug signing configuration + dev flavor
    flutter run -t lib/main_dev.dart  --debug --flavor=dev --no-sound-null-safety
    flutter run -t lib/main_dev.dart  --release --flavor=dev
    flutter build appbundle -t lib/main_dev.dart  --flavor=dev
    flutter build apk -t lib/main_dev.dart  --flavor=dev
 */
