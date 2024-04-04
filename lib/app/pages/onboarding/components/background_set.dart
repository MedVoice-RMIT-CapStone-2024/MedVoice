import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/module_utils.dart';

class BackgroundSetUp extends StatelessWidget {
  const BackgroundSetUp({
    Key? key,
    required this.child,
    required this.link,
    required this.isShowLogo,
    required this.isSignUpView,
  }) : super(key: key);

  final Widget child;
  final String link;
  final bool isShowLogo;
  final bool isSignUpView;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(link),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          width: double.infinity,
        ),
        (isShowLogo)
            ? Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: toSize(150),
                  width: toSize(150),
                  child: Image.asset(
                    'assets/images/medVoice.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : const SizedBox(),
        Center(
          child: Padding(
            padding: (!isSignUpView)
                ? EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4)
                : EdgeInsets.zero,
            child: child,
          ),
        )
      ],
    );
  }
}
