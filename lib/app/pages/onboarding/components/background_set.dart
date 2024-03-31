import 'package:flutter/cupertino.dart';

class BackgroundSetUp extends StatelessWidget {
  const BackgroundSetUp({
    Key? key,
    required this.size,
    required this.child,
  }) : super(key: key);

  final Size size;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg2.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: child,
    ));
  }
}
