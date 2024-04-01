import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/module_utils.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({
    Key? key,
    required this.size,
    required this.labelText,
    this.icon,
    this.hint,
  }) : super(key: key);

  final Size size;
  final String labelText;
  final IconData? icon;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: toSize(10)),
      padding:
          EdgeInsets.symmetric(horizontal: toSize(20), vertical: toSize(8)),
      width: size.width * 0.8,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w300,
            letterSpacing: 1,
          ),
          suffixIcon: Padding(
              padding: EdgeInsets.only(right: toSize(8.0)),
              child: Icon(icon, color: Colors.black)),
          fillColor: HexColor("FBE8F2"),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(toSize(29)), // Adjusted size
            borderSide: BorderSide.none,
          ),
          isDense: true,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w300,
          ),
          focusColor: HexColor("F2509C"),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(toSize(29)),
          //   borderSide: BorderSide(color: HexColor("F2509C")),
          // ),
        ),
      ),
    );
  }
}
