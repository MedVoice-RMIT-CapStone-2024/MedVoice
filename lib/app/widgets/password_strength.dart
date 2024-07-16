import 'package:flutter/material.dart';
import 'package:med_voice/app/utils/module_utils.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final double strength;
  final String strengthLabel;

  PasswordStrengthIndicator(
      {required this.strength, required this.strengthLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: strength,
            backgroundColor: Colors.grey[300],
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
            ),
          ),
        ],
      ),
    );
  }
}
