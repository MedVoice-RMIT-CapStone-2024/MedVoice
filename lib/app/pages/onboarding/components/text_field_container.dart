import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/module_utils.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Size size;
  final double? ratio;
  const TextFieldContainer({
    Key? key,
    required this.child,
    required this.size,
    this.ratio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: toSize(10)),
      padding:
          EdgeInsets.symmetric(horizontal: toSize(20), vertical: toSize(8)),
      width: size.width * (ratio ?? 0.8),
      // height: size.height * 0.08,
      decoration: BoxDecoration(
        color: HexColor("#FBE8F2"),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
