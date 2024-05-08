import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/module_utils.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({
    Key? key,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.showIconButton,
    this.onChanged,
    this.obscureText = false,
    this.icon,
    this.iconButton,
    this.hint,
  }) : super(key: key);
  final String labelText;
  final IconData? icon;
  final IconButton? iconButton;
  final bool showIconButton;
  final String? hint;
  final bool obscureText;
  final String? Function(String?)?
      validator; // Accepts a function for validation
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: toSize(10)),
      padding: EdgeInsets.symmetric(horizontal: toSize(20)),
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
            onChanged: onChanged,
            obscureText: obscureText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: toSize(15),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: toSize(8.0)),
                  child: showIconButton ? iconButton : Icon(icon),
                ),
                fillColor: HexColor("FBE8F2"),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(toSize(20)), // Adjusted size
                  borderSide: const BorderSide(color: Colors.black),
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
            validator: validator, // Pass the validation function
            controller: controller,
          ),
        ],
      ),
    );
  }
}
