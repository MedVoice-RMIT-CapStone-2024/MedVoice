import 'package:flutter/cupertino.dart';

class BackgroundSetUp extends StatelessWidget {
  const BackgroundSetUp({
    Key? key,
    required this.child,
    required this.link,
  }) : super(key: key);

  final Widget child;
  final String link;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(link),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: child,
    ));
  }
}
