import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/chat_bot/chat_bot_controller.dart';
import 'package:med_voice/app/widgets/prompt_field.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

class ChatBotView extends clean.View {
  ChatBotView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ChatBotView();
  }
}

class _ChatBotView extends BaseStateView<ChatBotView, ChatBotController> {
  _ChatBotView() : super(ChatBotController());
  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ChatBotController _controller = controller as ChatBotController;

    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return const Text("List");
                }),
          ),
        ),
        const PromptField(),
      ],
    );
  }
}