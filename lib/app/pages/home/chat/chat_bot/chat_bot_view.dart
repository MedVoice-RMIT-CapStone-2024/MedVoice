import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:lottie/lottie.dart';
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
  State<StatefulWidget> createState() => _ChatBotView();
}

class _ChatBotView extends BaseStateView<ChatBotView, ChatBotController> {
  _ChatBotView() : super(ChatBotController(AskRepositoryImpl()));

  TextEditingController messageController = TextEditingController();

  @override
  bool isInitialAppbar() => true;

  @override
  String appBarTitle() => "MVBot";

  @override
  Widget body(BuildContext context, BaseController controller) {
    final ChatBotController _controller = controller as ChatBotController;
    final size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: _controller.messages.length,
              itemBuilder: (context, index) => ChatItem(
                time: _controller.messages[index].time,
                isMe: _controller.messages[index].isMe,
                message: _controller.messages[index].message,
              ),
            ),
          ),
        ),
        if (controller.isLoading)
          Lottie.asset(
            controller.getLottieAnimationAsset(isDarkMode),
            width: 100,
            height: 50,
          ),
        if (_controller.areBubblesVisible)
          _buildInteractiveBubbles(_controller),
        _buildInputArea(size, theme, _controller),
      ],
    );
  }

  Widget _buildInteractiveBubbles(ChatBotController controller) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildBubble('Covid 19 symptoms',
            () => controller.sendBubbleContent('Covid 19 symptoms')),
        _buildBubble('Update information',
            () => controller.sendBubbleContent('Update information')),
        _buildBubble(
            'Scan QR code', () => controller.sendBubbleContent('Scan QR code')),
        _buildBubble('Record interaction',
            () => controller.sendBubbleContent('Record interaction')),
      ],
    );
  }

  Widget _buildBubble(String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text,
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Rubik')),
      ),
    );
  }

  Widget _buildInputArea(
      Size size, ThemeData theme, ChatBotController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: toSize(size.height * 0.02)),
      padding: EdgeInsets.symmetric(horizontal: toSize(size.width * 0.05)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: controller.onMessageChanged,
                  controller: messageController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Rubik'
                  ),
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: toSize(17),
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Rubik'),
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
                      borderSide:
                          const BorderSide(width: 3, color: Colors.black),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.sendMessage(messageController.text);
                  messageController.clear();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(toSize(size.width * 0.03)),
                  backgroundColor: controller.sendMode == SendMode.notTyping
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
    );
  }
}
