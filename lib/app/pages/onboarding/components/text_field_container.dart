import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/module_utils.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Size size;
  const TextFieldContainer({
    Key? key,
    required this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: toSize(10)),
      padding:
          EdgeInsets.symmetric(horizontal: toSize(20), vertical: toSize(8)),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: HexColor("#FBE8F2"),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
