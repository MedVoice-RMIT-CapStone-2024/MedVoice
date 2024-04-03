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
      padding: EdgeInsets.symmetric(horizontal: toSize(20)),
      width: size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Text(labelText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: toSize(11),
                  fontWeight: FontWeight.w400,
                  letterSpacing: toSize(1.5),
                )),
          ),
          TextFormField(
            decoration: InputDecoration(
                suffixIcon: Padding(
                    padding: EdgeInsets.only(right: toSize(8.0)),
                    child: Icon(icon, color: Colors.black)),
                fillColor: HexColor("FBE8F2"),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(toSize(20)), // Adjusted size
                  borderSide: BorderSide(color: Colors.black),
                ),
                isDense: true,
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(toSize(20)), // Adjusted size
                  borderSide: BorderSide(color: HexColor("#EC4B8B")),
                )),
          ),
        ],
      ),
    );
  }
}
