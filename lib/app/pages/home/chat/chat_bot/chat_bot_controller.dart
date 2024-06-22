import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/chat/chat_model.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/ask/ask_response.dart';
import 'package:med_voice/data/repository_impl/ask_repository_impl.dart';
import 'chat_bot_presenter.dart';

class ChatBotController extends BaseController {
  final ChatBotPresenter _presenter;
  List<ChatModel> messages = [];

  ChatBotController() : _presenter = ChatBotPresenter(AskRepositoryImpl()) {
    _initializePresenter();
  }

  void _initializePresenter() {
    _presenter.onGetAnswerSuccess = (AskResponse response) {
      messages.add(ChatModel(
          message: response.answer, isMe: false, time: DateTime.now()));
      refreshUI();
    };

    _presenter.onGetAnswerError = (dynamic error) {
      debugPrint("Error getting answer: $error");
      view.showErrorFromServer("Failed to get answer: $error");
    };

    _presenter.onCompleted = () {
      debugPrint("Get answer completed");
    };
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages
          .add(ChatModel(message: message, isMe: true, time: DateTime.now()));
      refreshUI();
      _presenter.executeGetAnswer(message);
    }
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
