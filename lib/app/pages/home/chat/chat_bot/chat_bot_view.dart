import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/chat/chat_bot/chat_bot_controller.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';

import 'package:provider/provider.dart';

import 'package:med_voice/app/pages/home/chat/chat_bot/chat_bot_controller.dart';
import 'package:med_voice/app/pages/home/chat/chat_item_view.dart';

import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

enum SendMode {
  typing,
  notTyping,
}

class ChatBotView extends clean.View {
  const ChatBotView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatBotView();
  }
}

class _ChatBotView extends BaseStateView<ChatBotView, ChatBotController> {
  _ChatBotView() : super(ChatBotController());
  SendMode _sendMode = SendMode.notTyping;
  TextEditingController messageController = TextEditingController();

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "MVBot";
  }

  @override
  void dispose() {
    messageController.dispose();
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    final ChatBotController _controller = controller as ChatBotController;

    final size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    return Column(
      children: [
        ChatItem(
          isMe: false,
          message: "Hello, I'm MVBot. How can I help you?",
        ),
        // ChatItem(
        //   isMe: true,
        //   message: "How to document patient history?",
        // ),
        // ChatItem(
        //   isMe: false,
        //   message:
        //       "You can use the following steps: \n 1. Open the patient's profile. \n 2. Click on the 'History' tab. \n 3. Click on the 'Add History' button.  \nIf you have any other questions, feel free to ask.",
        // ),
        // ChatItem(
        //   isMe: false,
        //   message: "Hello, I'm MVBot. How can I help you?",
        // ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child:
                //sample data
                // Column(
                //   children: [

                //   ],
                // ),
                Center(
              child: ListView.builder(
                itemCount: _controller.messages.length,
                itemBuilder: (context, index) => ChatItem(
                  isMe: _controller.messages[index].isMe,
                  message: _controller.messages[index].message,
                ),
              ),
            ),
          ),
        ),
        Container(
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
                      controller: messageController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: toSize(17),
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
                          borderRadius: BorderRadius.circular(
                              toSize(90)), // Adjusted size
                          borderSide:
                              const BorderSide(width: 3, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_sendMode == SendMode.typing) {
                        _controller.sendMessage(messageController.text);
                        messageController.clear();
                        setSendMode(SendMode.notTyping);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(toSize(size.width * 0.03)),
                      backgroundColor: _sendMode == SendMode.notTyping
                          ? theme.colorScheme.onSecondary.withOpacity(0.1)
                          : theme.colorScheme.onSecondary, // <-- Button color
                      foregroundColor:
                          theme.colorScheme.background, // <-- Splash color
                    ),
                    child: const Icon(Icons.near_me, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void setSendMode(SendMode sendMode) {
    setState(() {
      _sendMode = sendMode;
    });
  }
}
