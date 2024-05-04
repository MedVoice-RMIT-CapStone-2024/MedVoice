import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_voice/app/assets/image_assets.dart';

import '../utils/module_utils.dart';

class BackgroundSetUp extends StatelessWidget {
  const BackgroundSetUp({
    Key? key,
    required this.child,
    required this.link,
    required this.isShowLogo,
  }) : super(key: key);

  final Widget child;
  final String link;
  final bool isShowLogo;

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
                    ImageAssets.imgMedVoice,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : const SizedBox(),
        Center(
          child: child,
        )
      ],
    );
  }
}
