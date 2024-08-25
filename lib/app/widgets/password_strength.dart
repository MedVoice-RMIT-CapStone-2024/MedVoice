import 'package:flutter/material.dart';
import 'package:med_voice/app/utils/module_utils.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final double strength;
  final String strengthLabel;
  final ThemeData theme;

  const PasswordStrengthIndicator(
      {super.key, required this.strength, required this.strengthLabel, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: toSize(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: strength,
            backgroundColor: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(toSize(10)),
            valueColor: AlwaysStoppedAnimation<Color>(
              strength < 0.3
                  ? Colors.red
                  : strength < 0.7
                      ? Colors.orange
                      : Colors.green,
            ),
          ),
          SizedBox(height: toSize(8)),
          Text(
            strengthLabel,
            style: TextStyle(
              color: strength < 0.3
                  ? Colors.red
                  : strength < 0.7
                      ? Colors.orange
                      : Colors.green,
              fontFamily: 'Rubik'
            ),
          ),
        ],
      ),
    );
  }
}
