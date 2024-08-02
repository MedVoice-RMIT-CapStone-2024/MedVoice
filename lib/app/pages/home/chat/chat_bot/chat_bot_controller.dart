import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:med_voice/domain/entities/ask/chat_info.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/entities/ask/get_answer_params.dart';

import 'chat_bot_presenter.dart';

class ChatBotController extends BaseController {
  final ChatBotPresenter _presenter;
  TextEditingController textController = TextEditingController();
  List<ChatInfo> messages = [];
  List<String> bubbles = [];
  GetAnswerParams? getAnswerParams;
  ScrollController scrollController;
  bool compilingMessage = false;

  ChatBotController(this.scrollController, askRepository)
      : _presenter = ChatBotPresenter(askRepository);

  @override
  void firstLoad() {
    messages = [
      ChatInfo(
          isMe: false,
          message: 'Hello, I am MVBot. How can I assist you today?',
          time: DateTime.now()),
    ];
  }

  @override
  void onListener() {
    _presenter.onGetAnswerSuccess = (AskInfo response) {
      Future.delayed(const Duration(seconds: 2), () {
        messages.add(ChatInfo(
            message: response.mAnswer, isMe: false, time: DateTime.now()));
        compilingMessage = false;
        refreshUI();
      });
    };

    _presenter.onGetAnswerFailed = (error) {
      debugPrint("Error getting answer: $error");
      compilingMessage = false;
      view.showErrorFromServer("Failed to get answer: $error");
      refreshUI();
    };

    _presenter.onCompleted = () {
      debugPrint("Get answer completed");
    };
  }

  void sendMessage(String message) {
    messages.add(ChatInfo(message: message, isMe: true, time: DateTime.now()));
    compilingMessage = true;
    refreshUI();
    _presenter.executeGetAnswer(message, 'json');
    scrollToEndOfMessageList();
  }

  void scrollToEndOfMessageList() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }
}
