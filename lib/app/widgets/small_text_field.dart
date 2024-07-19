import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../utils/module_utils.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({
    Key? key,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.showIconButton,
    required this.fillColor,
    this.onChanged,
    this.obscureText = false,
    this.icon,
    this.iconButton,
    this.hint,
    this.iconColor,
  }) : super(key: key);
  final String labelText;
  final Color fillColor;
  final IconData? icon;
  final IconButton? iconButton;
  final bool showIconButton;
  final String? hint;
  final Color? iconColor;

  final bool obscureText;
  final String? Function(String?)?
      validator; // Accepts a function for validation
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
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
                  color: theme.colorScheme.onBackground,
                  fontSize: toSize(11),
                  // fontWeight: FontWeight.w400,
                  letterSpacing: toSize(1.5),
                  fontFamily: 'Rubik'
                )),
          ),
          TextFormField(
            onChanged: onChanged,
            obscureText: obscureText,
            style: TextStyle(
              color: theme.colorScheme.onBackground,
              fontSize: 14,
              // fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: toSize(8.0)),
                  child: showIconButton
                      ? iconButton
                      : Icon(icon, color: iconColor),
                ),
                fillColor: fillColor,
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(toSize(20)), // Adjusted size
                  borderSide: const BorderSide(color: Colors.black),
                ),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: theme.colorScheme.onBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                errorStyle: TextStyle(
                  color: theme.colorScheme.onSecondary,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme
                        .onSecondary, // Change this to your desired color
                    // Adjust the width if necessary
                  ),
                  borderRadius:
                      BorderRadius.circular(toSize(20)), // Adjusted size
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme
                        .onSecondary, // Change this to your desired color
                    // Adjust the width if necessary
                  ),
                  borderRadius:
                      BorderRadius.circular(toSize(20)), // Adjusted size
                )),
            validator: validator, // Pass the validation function
            controller: controller,
          ),
        ],
      ),
    );
  }
}
