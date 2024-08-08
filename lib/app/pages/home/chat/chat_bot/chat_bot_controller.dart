import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:med_voice/domain/entities/ask/chat_info.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/entities/ask/get_answer_params.dart';

import '../../../../../data/network/constants.dart';
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
            message: response.mAnswer ?? "",
            isMe: false,
            time: DateTime.now()));
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
    // AskRequest param = AskRequest(message, 'pdf');
    compilingMessage = true;
    refreshUI();
    // _presenter.executeGetAnswer(param);
    sendPostRequest(message);
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

  void sendPostRequest(String message) async {
    Map<String, dynamic>? responseBody;

    var client = http.Client();
    try {
      var url =
          Uri.parse(Constants.askEndpoint);
      var response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{"question":"$message","source_type":"pdf"}',
      );
      if (response.statusCode == 307) {
        var redirectedUrl = response.headers['location'];
        if (redirectedUrl != null) {
          var redirectedResponse = await client.post(
            Uri.parse(redirectedUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: '{"question":"$message","source_type":"pdf"}',
          );
          debugPrint('Redirected Response: ${redirectedResponse.body}');
          responseBody = jsonDecode(redirectedResponse.body);
          messages.add(ChatInfo(
              message: responseBody!['response'] ?? "",
              isMe: false,
              time: DateTime.now()));
          compilingMessage = false;
        }
      } else {
        debugPrint('Response: ${response.body}');
      }
    } finally {
      client.close();
    }
    refreshUI();
  }
}
