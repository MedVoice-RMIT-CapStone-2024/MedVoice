import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatelessWidget {
  final bool isMe;
  final String message;
  final DateTime time;

  const ChatItem(
      {Key? key, required this.isMe, required this.message, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    ThemeData themeData = Theme.of(context);
    String formattedTime = DateFormat('HH:mm').format(time);
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: toSize(10), horizontal: toSize(10)),
      child: Column(
        children: [
          Stack(children: [
            Text(
              formattedTime,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: toSize(12),
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Rubik'),
            )
          ]),
          SizedBox(height: toSize(5)),
          Stack(
            children: [
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  // Space for icon
                  if (!isMe) SizedBox(width: toSize(55)), // Space for icon
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: toSize(15),
                      horizontal: toSize(15),
                    ),
                    decoration: BoxDecoration(
                      color:
                          isMe ? theme.colorScheme.onSecondary : Colors.white,
                      border: Border.all(
                        color: theme.colorScheme.onBackground,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(toSize(isMe ? 35 : 0)),
                        topRight: Radius.circular(toSize(35)),
                        bottomLeft: Radius.circular(toSize(35)),
                        bottomRight: Radius.circular(isMe ? 0 : 35),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 4, bottom: 4, right: 0),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                          fontSize: toSize(16),
                          fontFamily: 'Rubik'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!isMe)
                Positioned(
                  left: 5,
                  top: 2,
                  child: Container(
                    padding: EdgeInsets.all(toSize(10)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(toSize(90)),
                    ),
                    child: Image.asset(
                      themeData.brightness == Brightness.dark
                          ? "assets/images/bot_dark.png"
                          : "assets/images/bot_light.png",
                      width: toSize(20),
                      height: toSize(20),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
