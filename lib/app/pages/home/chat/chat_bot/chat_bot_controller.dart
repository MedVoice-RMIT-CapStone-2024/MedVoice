import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/home/chat/chat_bot/chat_bot_presenter.dart';
import 'package:med_voice/app/pages/home/chat/chat_model.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';

enum SendMode {
  typing,
  notTyping,
}

class ChatBotController extends BaseController {
  final ChatBotPresenter presenter;
  List<ChatModel> messages = [];
  SendMode _sendMode = SendMode.notTyping;

  ChatBotController(askRepository)
      : presenter = ChatBotPresenter(askRepository);

  SendMode get sendMode => _sendMode;

  void setSendMode(SendMode mode) {
    _sendMode = mode;
    refreshUI();
  }

  @override
  void onInitState() {
    super.onInitState();
    presenter.getAnswerOnNext = (AskInfo response) {
      messages.add(ChatModel(
          message: response.mAnswer, isMe: false, time: DateTime.now()));
      refreshUI();
    };

    presenter.getAnswerOnError = (dynamic error) {
      debugPrint("Error getting answer: $error");
      view.showErrorFromServer("Failed to get answer: $error");
    };

    presenter.getAnswerOnComplete = () {
      debugPrint("Get answer completed");
    };
  }

  void sendMessage(String message) {
    if (_sendMode == SendMode.typing && message.isNotEmpty) {
      messages
          .add(ChatModel(message: message, isMe: true, time: DateTime.now()));
      refreshUI();
      presenter.getAnswer(message, "json");
      setSendMode(SendMode.notTyping);
    }
  }

  void onMessageChanged(String value) {
    setSendMode(value.isNotEmpty ? SendMode.typing : SendMode.notTyping);
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }

  @override
  void firstLoad() {
    // TODO: implement firstLoad
  }

  @override
  void onListener() {
    // TODO: implement onListener
  }
}
