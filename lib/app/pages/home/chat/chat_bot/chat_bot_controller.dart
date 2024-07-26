import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:med_voice/app/pages/home/chat/chat_bot/chat_bot_presenter.dart';
import 'package:med_voice/domain/entities/ask/chat_info.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/entities/ask/get_answer_params.dart';

enum SendMode {
  typing,
  notTyping,
}

class ChatBotController extends BaseController {
  final ChatBotPresenter _presenter;
  List<ChatInfo> messages = [];
  SendMode _sendMode = SendMode.notTyping;
  GetAnswerParams? getAnswerParams;

  ChatBotController(askRepository)
      : _presenter = ChatBotPresenter(askRepository);

  SendMode get sendMode => _sendMode;

  void setSendMode(SendMode mode) {
    _sendMode = mode;
    refreshUI();
  }

  void sendMessage(String message, {bool isUserInput = true}) {
    if (message.isNotEmpty) {
      messages.add(ChatInfo(
          message: message,
          isMe: true, // Always true for both user input and bubble content
          time: DateTime.now()));
      refreshUI();
      _presenter.executeGetAnswer(message, 'json');
      if (isUserInput) {
        setSendMode(SendMode.notTyping);
      }
    }
  }

  void sendBubbleContent(String content) {
    sendMessage(content, isUserInput: false);
  }

  void onMessageChanged(String value) {
    setSendMode(value.isNotEmpty ? SendMode.typing : SendMode.notTyping);
  }

  @override
  void firstLoad() {
    // TODO: implement firstLoad
  }

  @override
  void onListener() {
    // TODO: implement onListener
    _presenter.onGetAnswerSuccess = (AskInfo response) {
      messages.add(ChatInfo(
          message: response.mAnswer, isMe: false, time: DateTime.now()));
      refreshUI();
    };

    _presenter.onGetAnswerFailed = (error) {
      debugPrint("Error getting answer: $error");
      view.showErrorFromServer("Failed to get answer: $error");
    };

    _presenter.onCompleted = () {
      debugPrint("Get answer completed");
    };
  }
}
