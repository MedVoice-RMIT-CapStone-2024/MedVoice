import 'package:flutter/material.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

enum SendMode {
  typing,
  notTyping,
}

class PromptField extends StatefulWidget {
  const PromptField({super.key});

  @override
  State<PromptField> createState() => _PromptFieldState();
}

class _PromptFieldState extends State<PromptField> {
  SendMode _sendMode = SendMode.notTyping;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;

    final messageController = TextEditingController();
    return Container(
      margin: EdgeInsets.symmetric(vertical: toSize(size.height * 0.02)),
      padding: EdgeInsets.symmetric(horizontal: toSize(size.width * 0.05)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (value) => {
                    value.isNotEmpty
                        ? setSendMode(SendMode.typing)
                        : setSendMode(SendMode.notTyping)
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 17,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: toSize(10), horizontal: toSize(20)),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(
                        Icons.mic_none_outlined,
                        color: Colors.black,
                        size: toSize(30),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(toSize(90)), // Adjusted size
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(toSize(size.width * 0.03)),
                  backgroundColor: _sendMode == SendMode.notTyping
                      ? theme.colorScheme.onSecondary.withOpacity(0.1)
                      : theme.colorScheme.onSecondary, // <-- Button color
                  foregroundColor:
                      theme.colorScheme.background, // <-- Splash color
                ),
                child: Icon(Icons.near_me, color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }

  void setSendMode(SendMode sendMode) {
    setState(() {
      _sendMode = sendMode;
    });
  }
}
