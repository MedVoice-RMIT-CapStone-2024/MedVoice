import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/chat/chat_bot/chat_bot_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:med_voice/data/repository_impl/ask_repository_impl.dart';
import 'package:provider/provider.dart';
import 'package:med_voice/app/pages/home/chat/chat_item_view.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

class ChatBotView extends clean.View {
  const ChatBotView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatBotView();
  }
}

class _ChatBotView extends BaseStateView<ChatBotView, ChatBotController> {
  _ChatBotView() : super(ChatBotController(AskRepositoryImpl()));

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
  Widget body(BuildContext context, BaseController controller) {
    final ChatBotController _controller = controller as ChatBotController;
    final size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;

    return Column(
      children: [
        const ChatItem(
          isMe: false,
          message: "Hello, I'm MVBot. How can I help you?",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
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
                      onChanged: _controller.onMessageChanged,
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
                      _controller.sendMessage(messageController.text);
                      messageController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(toSize(size.width * 0.03)),
                      backgroundColor: _controller.sendMode ==
                              SendMode.notTyping
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
}
